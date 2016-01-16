SequenceType协议中定义的`map`函数功能很强大，这个函数起源于函数式编程，能够很方便的对数组中的每个元素进行变换处理，关于它的实现原理和使用方法可以参考我的这篇文章：[Swift数组变换](http://www.jianshu.com/p/7b1bb303ec45)。今天突然想到，如果数组非常大，`map`方法会不会出现性能问题？如果使用多线程技术是否可以提高`map`方法的执行效率？带着这样的问题，我开始了本次实(zuo)验(si)。

# 第一次尝试

虽然问题有些复杂，不过解决复杂的问题总是从处理简单问题开始的，我尝试直接使用异步多线程来处理：

```swift
extension Array {
    func kt_map<T>(transform: (Element) -> T) -> [T] {
	    let asyncQueue = dispatch_queue_create("com.gcd.kt", DISPATCH_QUEUE_CONCURRENT)
        var result: [T] = []
        
        dispatch_async(asyncQueue) { () -> Void in
            result = self.map(transform)
        }
        return result
    }
}

let test = [1,2,3,4,5,6,7,8,9]
let result = kt_map { $0 * 2}
print(result) 	// 输出结果： []
```

这显然是一个错的离谱的定义，最主要问题在于异步调用`self.map`方法后，没有等`result`变量被赋值就直接返回了(其实就是水平差)。不过，从第一次尝试中还是大概明确了方向，得出以下几个结论：

1. 方法内部肯定要用到多线程，但整体来说必须是同步的。必须等所有变换都执行结束，才能返回结果，Swift的`map`方法也是这么做的。

2. 因为方法是同步的，即使在方法内部新开一个线程，调用`self.map`，也不会节省任何时间，反而会因为线程切换浪费大量的时间。

3. 解决问题的思路应该是把数组拆成若干部分，在不同的线程中对不同的部分进行变换，最后再合并起来作为返回值。


# 第二次尝试

带着第一次尝试的收获，我开始了第二次尝试，这次代码比之前复杂得多，先上代码，标记数字的地方下面会有详细介绍：

```swift
func ktMap<T>(transform: (Element) -> T) -> [T] { // 1
    guard !self.isEmpty else { return [] }  // 如果数组为空就直接返回空数组
    
    var result: [(Int, [T])] = []   // 2
    let group = dispatch_group_create()
    
    // 3
    let subArrayLength: Int = max(1, self.count / NSProcessInfo.processInfo().activeProcessorCount / 2)
    
    for var step = 0; step * subArrayLength < self.count; step++ {
        var stepResult: [T] = []
        // 4
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            for i in (step * subArrayLength)..<((step + 1) * subArrayLength) {
                stepResult += [transform(self[i])]
            }
            result += [(step, stepResult)]
        }
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER)    // 5
    return result.sort { $0.0 < $1.0 }.flatMap { $0.1 }    // 6
}
```

1. 如果可以的话，我肯定仿照Swift对`map`方法的实现，把`transform `闭包声明为`@noescape`，可惜在GCD中要调用这个闭包，只能作罢。关于`@noescape`关键字的优点和限制，可以参考我的这篇博客：[自动闭包和noescape](http://www.jianshu.com/p/f9ba4c41d9c7)。

2. `result`是一个元组的数组。元组中第二个元素是原数组的子数组，第一个元素是这个子数组的序号。比如数组`[1,2,3,4,5,6]`有可能在`result`中表示为`[(0, [1,2,3]), (1, [4,5,6])]`。之所以这样拆分，是因为我要在多线程中分别处理每个子数组，最后再把他们合并成原来的数组。

3. `subArrayLength `表示每个子数组的长度。在整个除法表达式中，我们首先除以当前活跃的处理器核数，以iPhone6的A8处理器为例，它是双核的。因为一个核心对应两个线程，我希望能够在每个线程中处理一个子数组，所以又除以了2。其实这样做没有必要，因为不管我们在程序中开了多少个异步线程，真正对应到CPU的线程的过程是由GCD控制的。这就是操作系统中的“多对多”线程模型。不管怎么说，我们算出了每个子数组的长度。

4. 接下来是一个循环，在每一步中我们异步的执行一些操作（这些操作会在新线程里执行）。`stepResult`是一个子数组，用于存储这一段元素的变换结果。变换结束后，把`step`和`stepResult `分别作为元组的第一二个元素，存入`result `数组中

5. 调用`dispatch_group_wait `，这样我们会一直等到所有`group`中的方法结束后，才执行下面的代码。因为之前所有的任务都是放在`group `中执行的，所以这就保证了整个`map`方法是同步的。

6. 首先根据元组的第一个元素，也就是子数组序号排序，接着调用`flatMap`方法把其中的数组提取出来。关于`sort`和`flatMap`方法的用法，同样可以参考我的这篇文章：[Swift数组变换](http://www.jianshu.com/p/7b1bb303ec45)。

方法实现完了以后，再次调用它，查看结果。可怜的是还不如以前，这次直接崩溃了。根据崩溃提示，问题主要出在这一段：

```swift
dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    for i in (step * subArrayLength)..<((step + 1) * subArrayLength) {
        stepResult += [transform(self[i])]
    }
    result += [(step, stepResult)]
}
```

# 第三次尝试

我在异步方法中向数组`result `添加新的元素，这样是很危险的。准确的说是程序几乎是一定会崩溃的，具体原因可以参考这篇文章：[Swift数组扩容原理](http://www.jianshu.com/p/2fce6a0bb17b)。正确的做法是加一个锁，保证每次只有一个添加元素的操作在执行。另一种常见的方案是使用同步队列，它可以保证队列中所有的任务依次进行。

另一个问题在于，在最外层的for循环中，step变量表示当前是第几步。它随着循环的进行，不断自增。如果在循环内部总是使用`step`，就有可能获取到错误的`step`值。这一点也要格外重视，在平时的编程中，for循环总是同步的，当前循环不结束就不会开始下一个循环。在多线程编程中就完全不是这样，循环内部调用了异步方法，所以每个循环会非常快的结束。正确的做法是在循环内部用一个临时常量保存`step`的值。

最后一个问题是处理每一段子数组时，它的长度总是固定的，也就是`subArrayLength `的值。但是在处理最后一个子数组时可能导致下标越界，即使没有越界，这些操作也是多余的。


解决这三个问题后，我完成了最终的`map`方法实现，具体的解释在下面：

```swift
func ktMap<T>(transform: (Element) -> T) -> [T] {
    guard !self.isEmpty else { return [] }  // 如果数组为空就直接返回空数组
    
    var result: [(Int, [T])] = []
    let group = dispatch_group_create()
    let mutex = dispatch_semaphore_create(1)    // 1
    let syncQueue = dispatch_queue_create("com.gcd.kt", DISPATCH_QUEUE_SERIAL)    // 2
    
    let subArrayLength: Int = max(1, self.count / NSProcessInfo.processInfo().activeProcessorCount / 2)
    
    for var step = 0; step * subArrayLength < self.count; step++ {
        let localStep = step	// 3
        var stepResult: [T] = []

        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        	// 4
            for i in (localStep * subArrayLength)..<min(((localStep + 1) * subArrayLength), self.count) {
                stepResult += [transform(self[i])]
            }
            
            // 5
            dispatch_semaphore_wait(mutex, DISPATCH_TIME_FOREVER)
            result += [(localStep, stepResult)]
            dispatch_semaphore_signal(mutex)
            
            // 6
//          dispatch_group_async(group, syncQueue) {
//              result += [(localStep, stepResult)]
//          }
        }
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
    return result.sort { $0.0 < $1.0 }.flatMap { $0.1 }
}
```

1. 使用互斥锁保证不会有多个数组添加元素的操作同时进行
2. 同步队列也是一种解决方式
3. 在for循环体中用一个常量保存下来当前的`step`值，后面用`localStep `替代所有的`step`
4. 数组的右边界进行一个判断，最多不超过`self.count`
5. 这是使用互斥锁的解决方案
6. 这里被注释了，可以替换掉上面那部分。必须使用`dispatch_group_async `，因为下面还用到`dispatch_group_wait `，必须确保group中所有操作执行完了才能排序。

# 测试

首先进行正确性测试，我举了几个例子，目前来看没有问题，这里列出一个：

```swift
let test = [1,2,3,4,5,6,7,8,9]
let result = test.ktMap { $0 * 2}
print(result)	//输出结果：[2, 4, 6, 8, 10, 12, 14, 16]
```
为了进行性能测试，首先我定义了两个辅助函数：

```swift
func ktTimer<T>(description: String, @autoclosure task performTask: () -> T) -> Void {
    let start = NSDate().timeIntervalSince1970
    performTask()
    
    let duration = NSDate().timeIntervalSince1970 - start
    print("Mission '\(description)' completed in \(duration * 1000) ms")
}

func transformGenerater(duration duration: Float) -> Int -> Int {
    return {
        NSThread.sleepForTimeInterval(NSTimeInterval(duration))
        return $0
    }
}
```

第一个函数用于计时，以毫秒为单位输出参数`performTask `的执行时间。

第二个函数用于模拟耗时的计算，它的返回值类型是`Int -> Int`，可以作为`map`函数的参数。它的参数`delay `可以模拟计算所需要的时间。

根据我的猜测，在处理少量数据时，多线程`map`的性能应该不如Swift自己实现的`map`，因为有一些额外的创建、切换线程以及同步操作。在数据量较大时，因为电脑上是八线程处理器(iPhone是4线程)，理论上`map`方法的耗时应该是自定义的`ktMap`方法的8倍。不过因为有这些固定的时间开销，实际上并不能达到理论上的优化效果。

为了验证猜测，我进行了下面八组测试：

```swift
let littleArray: Array<Int> = [1,2,3,4,5,6,7,8,9,10]   // 模拟数据量小的情况
var largeArray: Array<Int> = []   // 模拟数据量大的情况

for i in 0..<1000 {
    largeArray.append(i)
}

ktTimer("1.少量数据，多线程map方法，耗时计算", task: littleArray.ktMap(transformGenerater(duration: 0.01)))
ktTimer("2.少量数据，普通map方法，耗时计算", task: littleArray.map(transformGenerater(duration: 0.01)))
ktTimer("3.少量数据，多线程map方法，不耗时计算", task:  littleArray.ktMap(transformGenerater(duration: 0)))
ktTimer("4.少量数据，普通map方法，不耗时计算", task: littleArray.map(transformGenerater(duration: 0)))
print("")
ktTimer("5.大量数据，多线程map方法，耗时计算", task: largeArray.ktMap(transformGenerater(duration: 0.01)))
ktTimer("6.大量数据，普通map方法，耗时计算", task: largeArray.map(transformGenerater(duration: 0.01)))
ktTimer("7.大量数据，多线程map方法，不耗时计算", task: largeArray.ktMap(transformGenerater(duration: 0)))
ktTimer("8.大量数据，普通map方法，不耗时计算", task: largeArray.map(transformGenerater(duration: 0)))
```

输出结果如下：

```swift
Mission '1.少量数据，多线程map方法，耗时计算' completed in 15.394926071167 ms
Mission '2.少量数据，普通map方法，耗时计算' completed in 112.390041351318 ms
Mission '3.少量数据，多线程map方法，不耗时计算' completed in 0.3509521484375 ms
Mission '4.少量数据，普通map方法，不耗时计算' completed in 0.0109672546386719 ms

Mission '5.大量数据，多线程map方法，耗时计算' completed in 717.829942703247 ms
Mission '6.大量数据，普通map方法，耗时计算' completed in 11682.7671527863 ms
Mission '7.大量数据，多线程map方法，不耗时计算' completed in 2.37083435058594 ms
Mission '8.大量数据，普通map方法，不耗时计算' completed in 0.446796417236328 ms
```

每次运行的具体结果不同，通过对比可以发现：

1. 对比1和2，假设`transform`的闭包执行时间是0.01秒，`ktMap`方法的耗时只有同步方法的7.3分之一。基本符合我之前的猜想。
2. 对比3和4，如果只是把原来的元素翻倍，多线程方法的耗时反而是同步方法的35倍。而且即使数据量达到1000，对比7、8也可以发现同步方法快了好几倍

于是得出一个结论：

> 是否需要使用多线程map方法的依据不是数组元素的数量多少，而是元素变换操作的复杂度

**过早的优化是万恶之源！**

**过早的优化是万恶之源！**

**过早的优化是万恶之源！**