//
//  Closure.swift
//  Handy
//
//  Created by 张星宇 on 16/2/2.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation
import Cocoa

enum Theme {
    case Day, Night, Dusk, Dawn
    
    func applyColor() {
        let backgroundColor: NSColor = {
            switch self {
            case Day: return NSColor.whiteColor()
            case Night: return NSColor.darkGrayColor()
            default: return NSColor.blackColor()
            }
        }()
    }
}