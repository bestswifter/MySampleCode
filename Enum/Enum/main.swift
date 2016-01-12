//
//  main.swift
//  Enum
//
//  Created by 张星宇 on 16/1/12.
//  Copyright © 2016年 张星宇. All rights reserved.
//

/// 测试红黑树的实现
import Foundation

/// OC中的枚举一般是这样用的
var enumValue = MyEnum.ValueA

 /// 关联类型的基本使用
enum Password {
    case DeigtPassword(Int)
    case StringPassword(String)
}

var password = Password.DeigtPassword(123456)
password = .StringPassword("123456")

switch password {
case .DeigtPassword(let digit): print("这是数字密码： \(digit)")
case .StringPassword(let digit): print("这是字符串密码： \(digit)")
}

/// 测试contains方法
let root = Tree(3), x = Tree<Int>()
print(root.contains(3))  // true
print(x.contains(3))  // false

/// 测试Insert方法
let alphabet = Tree("the quick brown fox jumps over the lazy dog".characters)
for node in alphabet {
    print(node)  // 打印从a到z的所有字母
}