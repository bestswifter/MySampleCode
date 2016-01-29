//
//  LoopLabel.swift
//  SwiftMysterious
//
//  Created by 张星宇 on 16/1/29.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

let firstNames = ["Neil","Kt","Bob"]
let lastNames = ["Zhou","Zhang","Wang","Li"]

func normalBreak() {
    print("\n正常的break循环")
    for firstName in firstNames {
        var isFound = false
        for lastName in lastNames {
            if firstName == "Kt" && lastName == "Zhang" {
                isFound = true
                break
            }
            print(firstName + " " + lastName)
        }
        
        if isFound {
            break
        }
    }
}

func breakWithLoopLabel() {
    print("\n使用循环标签的break循环")
    outsideloop: for firstName in firstNames {
        innerloop: for lastName in lastNames {
            if firstName == "Kt" && lastName == "Zhang" {
                break outsideloop
            }
            print(firstName + " " + lastName)
        }
    }
}
