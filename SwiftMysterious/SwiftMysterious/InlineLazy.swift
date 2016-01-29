//
//  InlineLazy.swift
//  SwiftMysterious
//
//  Created by 张星宇 on 16/1/29.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

/// Important!!!!
/// 虽然懒加载的本质是闭包，而且闭包中捕获了self，但是这里并不会产生循环引用
/// 猜测Swift在捕获self时，自动把它标记为unowned

class ExpensiveObject {
    init () {
        print("初始化ExpensiveObject对象的过程非常耗时")
    }
}

class PersonOld {
    lazy var expensiveObject: ExpensiveObject = {
        return self.createExpensiveObject()    // 传统实现方式
    }()
    
    private func createExpensiveObject() -> ExpensiveObject {
        return ExpensiveObject()
    }
    
    deinit {
        print("Person 对象销毁")
    }
}

class Person {
    // 内联的lazy属性可以简化不少代码
    lazy var expensiveObject: ExpensiveObject = self.createExpensiveObject()
    
    private func createExpensiveObject() -> ExpensiveObject {
        return ExpensiveObject()
    }
    
    deinit {
        print("Person 对象销毁")
    }
}

func lazyVariable() {
    print("传统的lazy属性的实现")
    let p = PersonOld()
    _ = p.expensiveObject
}

func inlineLazyVariable() {
    print("\n内联lazy属性的实现")
    let p = Person()
    _ = p.expensiveObject
}