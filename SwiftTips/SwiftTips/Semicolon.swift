//
//  Semicolon.swift
//  Handy
//
//  Created by 张星宇 on 16/2/2.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

func doSomething() {
    let error: AnyObject? = nil
    guard error == nil else { print("Error information"); return }
    
    /**
    *  Old version
    */
    guard error == nil
    else {
        print("Error information")
        return
    }
}