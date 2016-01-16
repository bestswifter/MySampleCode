//
//  main.swift
//  利息
//
//  Created by 张星宇 on 16/1/16.
//  Copyright © 2016年 张星宇. All rights reserved.
//

import Foundation

func ktTimer<T>(description: String, @autoclosure task performTask: () -> T) -> Void {
    let start = NSDate().timeIntervalSince1970
    performTask()
    
    let duration = NSDate().timeIntervalSince1970 - start
    print("Mission '\(description)' completed in \(duration * 1000) ms")
}

func transformGenerater(duration duration: Float) -> Int -> Int {
    return {
        NSThread.sleepForTimeInterval(NSTimeInterval(duration))
        return $0 * 2
    }
}

/// 正确性测试
let test = UnitTest()
test.beginTest()

/// 性能测试
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

