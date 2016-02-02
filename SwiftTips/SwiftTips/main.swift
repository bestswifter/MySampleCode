//
//  main.swift
//  SwiftTips
//
//  Created by 张星宇 on 16/2/2.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

var person = Person()
person.changeName("kt")

// 可以获取name属性的值
print(person.name)

// 报错，不能在PrivateSet.swift文件外对name属性赋值
//person.name = "newName"

/// 可以简化reuseIdentifier
let reuseIdentifier = String(TableViewCell)
print(reuseIdentifier)

// 可以把多个相关联的变量声明在一个元组中
var (top, left, width, height) = (0.0, 0.0, 100.0, 50.0)
//rect.width = width

/**
*  自定义断点
*/
customDebug()
