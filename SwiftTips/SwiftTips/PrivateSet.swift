//
//  PrivateSet.swift
//  Handy
//
//  Created by 张星宇 on 16/2/2.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

struct Person {
    private(set) var name = "Unknown"
}

extension Person {
    mutating func changeName(newName: String) {
        self.name = newName
    }
}