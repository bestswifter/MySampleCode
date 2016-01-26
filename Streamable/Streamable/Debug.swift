//
//  Debug.swift
//  Streamable
//
//  Created by 张星宇 on 16/1/26.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

struct PersonDebug {
    var name: String
    private var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension PersonDebug: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return "In CustomStringConvertible Protocol"
    }
    
    var debugDescription: String {
        return "In CustomDebugStringConvertible Protocol"
    }
}

// print优先调用CustomStringConvertible
func testCustomStringConvertible() {
    print("print结构体")
    let kt = PersonDebug(name: "kt", age: 21)
    print(kt)
    print(String(kt))
    print("")
}

// debugPrint优先调用CustomDebugStringConvertible
func testCustomDebugStringConvertible() {
    print("debugPrint结构体")
    let kt = PersonDebug(name: "kt", age: 21)
    debugPrint(kt)
    print(String(reflecting: kt))
    print("")
}