> 本文是直播分享的简单文字整理，视频地址：[优酷](http://v.youku.com/v_show/id_XMTUzNzQzMDU0NA==.html)、[YouTube](https://youtu.be/hPR67T9mbsY)
> Demo 地址：[KtTableView](https://github.com/bestswifter/MySampleCode/tree/master/KtTableView)

# MVC

讨论解耦之前，我们要弄明白 MVC 的核心：控制器（以下简称 C）负责模型（以下简称 M）和视图（以下简称 V）的交互。

这里所说的 M，通常不是一个单独的类，很多情况下它是由多个类构成的一个层。最上层的通常是以 `Model` 结尾的类，它直接被 C 持有。`Model` 类还可以持有两个对象：

1. Item：它是实际存储数据的对象。它可以理解为一个字典，和 V 中的属性一一对应
2. Cache：它可以缓存自己的 Item（如果有很多）

常见的误区：

1. 一般情况下数据的处理会放在 M 而不是 C（C 只做不能复用的事） 
2. 解耦不只是把一段代码拿到外面去。而是关注是否能合并重复代码， 并且有良好的拖展性。

# 原始版

在 C 中，我们创建 `UITableView` 对象，然后将它的数据源和代理设置为自己。也就是自己管理着 UI 逻辑和数据存取的逻辑。在这种架构下，主要存在这些问题：

1. 违背 MVC 模式，现在是 V 持有 C 和 M。
2. C 管理了全部逻辑，耦合太严重。
3. 其实绝大多数 UI 相关都是由 Cell 而不是 `UITableView` 自身完成的。

为了解决这些问题，我们首先弄明白，数据源和代理分别做了那些事。

### 数据源

它有两个必须实现的代理方法：

```objc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
```

简单来说，只要实现了这个两个方法，一个简单的 `UITableView` 对象就算是完成了。

除此以外，它还负责管理 `section` 的数量，标题，某一个 `cell` 的编辑和移动等。

### 代理

代理主要涉及以下几个方面的内容：

1. cell、headerView 等展示前、后的回调。
2. cell、headerView 等的高度，点击事件。

最常用的也是两个方法：

```objc
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
```

提醒：绝大多数代理方法都有一个 `indexPath` 参数

# 优化数据源

最简单的思路是单独把数据源拿出来作为一个对象。

这种写法有一定的解耦作用，同时可以有效减少 C 中的代码量。然而总代码量会上升。我们的目标是减少不必要的代码。

比如获取每一个 `section` 的行数，它的实现逻辑总是高度类似。然而由于数据源的具体实现方式不统一，所以每个数据源都要重新实现一遍。

### SectionObject

首先我们来思考一个问题，数据源作为 M，它持有的 Item 长什么样？答案是一个二维数组，每个元素保存了一个 `section` 所需要的全部信息。因此除了有自己的数组（给cell用）外，还有 section 的标题等，我们把这样的元素命名为 `SectionObject`：

```
@interface KtTableViewSectionObject : NSObject

@property (nonatomic, copy) NSString *headerTitle; // UITableDataSource 协议中的 titleForHeaderInSection 方法可能会用到
@property (nonatomic, copy) NSString *footerTitle; // UITableDataSource 协议中的 titleForFooterInSection 方法可能会用到

@property (nonatomic, retain) NSMutableArray *items;

- (instancetype)initWithItemArray:(NSMutableArray *)items;

@end
```

### Item

其中的 `items` 数组，应该存储了每个 cell 所需要的 `Item`，考虑到 `Cell` 的特点，基类的 `BaseItem` 可以设计成这样：

```objc
@interface KtTableViewBaseItem : NSObject

@property (nonatomic, retain) NSString *itemIdentifier;
@property (nonatomic, retain) UIImage *itemImage;
@property (nonatomic, retain) NSString *itemTitle;
@property (nonatomic, retain) NSString *itemSubtitle;
@property (nonatomic, retain) UIImage *itemAccessoryImage;

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage;

@end
```

### 父类实现代码

规定好了统一的数据存储格式以后，我们就可以考虑在基类中完成某些方法了。以 `- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section` 方法为例，它可以这样实现：

```objc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count > section) {
        KtTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.items.count;
    }
    return 0;
}
```

比较困难的是创建 `cell`，因为我们不知道 `cell` 的类型，自然也就无法调用 `alloc` 方法。除此以外，`cell` 除了创建，还需要设置 UI，这些都是数据源不应该做的事。

这两个问题的解决方案如下：

1. 定义一个协议，父类返回基类 `Cell`，子类视情况返回合适的类型。
2. 为 `Cell` 添加一个 `setObject` 方法，用于解析 Item 并更新 UI。

### 优势

经过这一番折腾，好处是相当明显的：

1. 子类的数据源只需要实现 `cellClassForObject` 方法即可。原来的数据源方法已经在父类中被统一实现了。
2. 每一个 Cell 只要写好自己的 `setObject` 方法，然后坐等自己被创建，被调用这个方法即可。
3. 子类通过 `objectForRowAtIndexPath` 方法可以快速获取 item，不用重写。

对照 demo（SHA-1：6475496），感受一下效果。

# 优化代理

我们以之前所说的，代理协议中常用的两个方法为例，看看怎么进行优化与解耦。

首先是计算高度，这个逻辑并不一定在 C 完成，由于涉及到 UI，所以由 Cell 负责实现即可。而计算高度的依据就是 Object，所以我们给基类的 Cell 加上一个类方法：

```objc
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(KtTableViewBaseItem *)object;
```

另外一类问题是以处理点击事件为代表的代理方法， 它们的主要特点是都有 `indexPath` 参数用来表示位置。然而实际在处理过程中，我们并不关系位置，关心的是这个位置上的数据。

因此，我们对代理方法做一层封装，使得 C 调用的方法中都是带有数据参数的。因为这个数据对象可以从数据源拿到，所以我们需要能够在代理方法中获取到数据源对象。

为了实现这一点， 最好的办法就是继承 `UITableView`：

```objc
@protocol KtTableViewDelegate<UITableViewDelegate>

@optional

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;
- (UIView *)headerViewForSectionObject:(KtTableViewSectionObject *)sectionObject atSection:(NSInteger)section;

// 将来可以有 cell 的编辑，交换，左滑等回调
// 这个协议继承了UITableViewDelegate ，所以自己做一层中转，VC 依然需要实现某

@end

@interface KtBaseTableView : UITableView<UITableViewDelegate>

@property (nonatomic, assign) id<KtTableViewDataSource> ktDataSource;
@property (nonatomic, assign) id<KtTableViewDelegate> ktDelegate;

@end
```

cell 高度的实现如下，调用数据源的方法获取到数据：

```ojbc
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<KtTableViewDataSource> dataSource = (id<KtTableViewDataSource>)tableView.dataSource;
    
    KtTableViewBaseItem *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    
    return [cls tableView:tableView rowHeightForObject:object];
}
```

### 优势

通过对 `UITableViewDelegate` 的封装（其实主要是通过 `UITableView` 完成），我们获得了以下特性：

1. C 不用关心 Cell 高度了，这个由每个 Cell 类自己负责
2. 如果数据本身存在数据源中，那么在代理协议中它可以被传给 C，免去了 C 重新访问数据源的操作。
3. 如果数据不存在于数据源，那么代理协议的方法会被正常转发（因为自定义的代理协议继承自 `UITableViewDelegate `）

对照 demo（SHA-1：ca9b261），感受一下效果。

# 更加 MVC，更加简洁

在上面的两次封装中，其实我们是把 `UITableView` 持有原生的代理和数据源，改成了 `KtTableView` 持有自定义的代理和数据源。并且默认实现了很多系统的方法。

到目前为止，看上去一切都已经完成了，然而实际上还是存在一些可以改进的地方：

1. 目前仍然不是 MVC 模式！
2. C 的逻辑和实现依然可以进一步简化

基于以上考虑， 我们实现一个 `UIViewController` 的子类，并且把数据源和代理封装到 C 中。

```objc
@interface KtTableViewController : UIViewController<KtTableViewDelegate, KtTableViewControllerDelegate>

@property (nonatomic, strong) KtBaseTableView *tableView;
@property (nonatomic, strong) KtTableViewDataSource *dataSource;
@property (nonatomic, assign) UITableViewStyle tableViewStyle; // 用来创建 tableView

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
```

为了确保子类创建了数据源，我们把这个方法定义到协议里，并且定义为 `required`。

# 成果与目标

现在我们梳理一下经过改造的 `TableView` 该怎么用：

1. 首先你需要创建一个继承自 `KtTableViewController` 的视图控制器，并且调用它的 `initWithStyle` 方法。
	
	```objc
	KTMainViewController *mainVC = [[KTMainViewController alloc] initWithStyle:UITableViewStylePlain];
	```
2. 在子类 VC 中实现 `createDataSource` 方法，实现数据源的绑定。

	```objc
	- (void)createDataSource {
		self.dataSource = [[KtMainTableViewDataSource alloc] init]; // 这	一步创建了数据源
	}
	```
	
3. 在数据源中，需要指定 cell 的类型。

	```objc
	- (Class)tableView:(UITableView *)tableView cellClassForObject:(KtTableViewBaseItem *)object {
		return [KtMainTableViewCell class];
	}
	```
	
4. 在 Cell 中，需要通过解析数据，来更新 UI 并返回自己的高度。

	```objc
	+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(KtTableViewBaseItem *)object {
		return 60;
	}
	// Demo 中沿用了父类的 setObject 方法。
	```

### 下一步做什么？

关于 `TableView` 的讨论远远没有结束，我列出了以下需要解决的问题

1. 在这种设计下，数据的回传不够方便，比如 cell 的给 C 发消息。
2. 下拉刷新与上拉加载如何集成
3. 网络请求的发起，与解析数据如何集成

关于第一个问题，其实是普通的 MVC 模式中 V 和 C 的交互问题，可以在 Cell（或者其他类） 中添加 weak 属性达到直接持有的目的，也可以定义协议。

问题二和三是另一大块话题，网络请求大家都会实现，但如何优雅的集成进框架，保证代码的简单和可拓展，就是一个值得深入思考，研究的问题了。我会在下次有空的时候和大家分享这个问题。