//
//  extension.swift
//  利息
//
//  Created by 张星宇 on 16/1/16.
//  Copyright © 2016年 张星宇. All rights reserved.
//

import Foundation

extension Array {
    func ktMap<T>(transform: (Element) -> T) -> [T] {
        guard !self.isEmpty else { return [] }  // 如果数组为空就直接返回空数组
        
        var result: [(Int, [T])] = []
        let group = dispatch_group_create()
        let syncQueue = dispatch_queue_create("com.gcd.kt", DISPATCH_QUEUE_SERIAL)
        
        let subArrayLength: Int = max(1, self.count / NSProcessInfo.processInfo().activeProcessorCount / 2)
        
        for var step = 0; step * subArrayLength < self.count; step++ {
            var stepResult: [T] = []
            let localStep = step
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                for i in (localStep * subArrayLength)..<min(((localStep + 1) * subArrayLength), self.count) {
                    stepResult += [transform(self[i])]
                }
                
                dispatch_group_async(group, syncQueue) {
                    result += [(localStep, stepResult)]
                }
            }
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        return result.sort { $0.0 < $1.0 }.flatMap { $0.1 }
    }
}
