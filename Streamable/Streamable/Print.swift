//
//  Print.swift
//  Streamable
//
//  Created by 张星宇 on 16/1/26.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

struct Person {
    var name: String
    private var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

//    1. 调用不带`output`参数的`print`函数，函数内部生成`_Stdout `类型的输出流，调用`_print`函数
//    2. 在`_print`函数中国处理完`separator`和`terminator `等格式参数后，调用`_print_unlocked `函数处理字符串输出。
//    3. 在`_print_unlocked `函数的第一个if判断中，因为字符串类型实现了`Streamable `协议，所以调用字符串的`writeTo`函数，写入到输出流中。
//    4. 根据字符串的`writeTo`函数的定义，它在内部调用了输出流的`write`方法
//    5. `_Stdout`在其`write`方法中，调用C语言的`putchar`函数输出字符串的每个字符
func testPrintString() {
    print("Hello, world!")
}

//    1. 调用不带`output`参数的`print`函数，函数内部生成`_Stdout `类型的输出流，调用`_print`函数
//    2. 在`_print`函数中国处理完`separator`和`terminator `等格式参数后，调用`_print_unlocked `函数处理字符串输出。
//    3. 截止目前和输出字符串一致，不过Int类型(以及其他除了和字符有关的几乎所有类型)没有实现`Streamable `协议，它实现的是`CustomStringConvertible `协议，定义了自己的计算属性`description`
//    4. `description`是一个字符串类型，调用字符串的`writeTo`方法此前已经讲过，就不再赘述了。
func testPrintInteger() {
    print(123)
}


//1. 调用不带`output`参数的`print`函数，函数内部生成`_Stdout `类型的输出流，调用`_print`函数
//2. 在`_print`函数中国处理完`separator`和`terminator `等格式参数后，调用`_print_unlocked `函数处理字符串输出。
//3. 在`_print_unlocked `中调用`_adHocPrint `函数
//4. switch语句匹配，参数类型是结构体，执行对应case语句中的代码
func testPrintStruct() {
    print("测试直接打印结构体")
    let kt = Person(name: "kt", age: 21)
    print(kt)
    print("")
}

// 字符串的初始化方法中调用`_print_unlocked `函数
func testCreateString() {
    print("测试通过结构体创建字符串并输出到屏幕")
    let kt = Person(name: "kt", age: 21)
    let string = String(kt)
    print(string)
    print("")
}