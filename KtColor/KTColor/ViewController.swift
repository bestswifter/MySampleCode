//
//  ViewController.swift
//  KTColor
//
//  Created by 张星宇 on 16/2/14.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

/// 通过继承实现字符串字面量创建UIColor对象
class KtColor: UIColor, StringLiteralConvertible {
    required init(stringLiteral value: String) {
        super.init(red: 0.5, green: 0.8, blue: 0.25, alpha: 1)
    }
    
    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required convenience init(colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
        self.init(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = "224, 222, 255, 0.5".ktcolor
        self.view.backgroundColor = "#DC143C".ktcolor
        self.view.backgroundColor = "SkyBlue".ktcolor
        self.view.backgroundColor = "224,222,255".ktcolor
        self.view.backgroundColor = "224, 222, 255" as KtColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

