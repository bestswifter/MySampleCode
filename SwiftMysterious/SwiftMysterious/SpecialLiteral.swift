//
//  SpecialLiteral.swift
//  SwiftMysterious
//
//  Created by 张星宇 on 16/1/29.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation

func specialLitertalExpression() {
    print("\n用于调试的特殊字面量表达式")
    print(__FILE__)
    print(__FUNCTION__)
    print(__LINE__)
    print(__COLUMN__)   // 输出结果为11，因为有4个空格，print是五个字符，还有一个左括号。
}