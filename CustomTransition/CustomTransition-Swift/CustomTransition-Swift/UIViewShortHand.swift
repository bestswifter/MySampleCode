//
//  UIViewShortHand.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation
import UIKit

extension CollectionType where Generator.Element == Int {
    public var color: UIColor {
        guard self.count == 3 else { fatalError("You should specify R,G,B values with 3 integers") }
        let r = CGFloat(self[startIndex]) / CGFloat(255)
        let g = CGFloat(self[startIndex.advancedBy(1)]) / CGFloat(255)
        let b = CGFloat(self[startIndex.advancedBy(2)]) / CGFloat(255)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}