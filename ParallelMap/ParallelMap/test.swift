//
//  test.swift
//  利息
//
//  Created by 张星宇 on 16/1/16.
//  Copyright © 2016年 张星宇. All rights reserved.
//

import Foundation

class UnitTest {
    func beginTest() {
        let result1 = [1].ktMap { $0 * 2}
        let expectedResult1 = [2]
        
        let result2 = [1,2].ktMap { $0 * 2}
        let expectedResult2 = [2, 4]
        
        let result3 = [1,2,3].ktMap { $0 * 2}
        let expectedResult3 = [2, 4, 6]
        
        let result4 = [1,2,3,4].ktMap { $0 * 2}
        let expectedResult4 = [2, 4, 6, 8]
        
        let result5 = [1,2,3,4,5].ktMap { $0 * 2}
        let expectedResult5 = [2, 4, 6, 8, 10]
        
        let result6 = [1,2,3,4,5,6].ktMap { $0 * 2}
        let expectedResult6 = [2, 4, 6, 8, 10, 12]
        
        let result7 = [1,2,3,4,5,6,7].ktMap { $0 * 2}
        let expectedResult7 = [2, 4, 6, 8, 10, 12, 14]
        
        let result8 = [1,2,3,4,5,6,7,8].ktMap { $0 * 2}
        let expectedResult8 = [2, 4, 6, 8, 10, 12, 14, 16]
        
        let result9 = [1,2,3,4,5,6,7,8,9].ktMap { $0 * 2}
        let expectedResult9 = [2, 4, 6, 8, 10, 12, 14, 16, 18]
        
        let result10 = [1,2,3,4,5,6,7,8,9,10].ktMap { $0 * 2}
        let expectedResult10 = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        
        let result11 = [1,2,3,4,5,6,7,8,9,10,11].ktMap { $0 * 2}
        let expectedResult11 = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22]
        
        let result12 = [1,2,3,4,5,6,7,8,9,10,11,12].ktMap { $0 * 2}
        let expectedResult12 = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24]
        
        let result13 = [1,2,3,4,5,6,7,8,9,10,11,12,13].ktMap { $0 * 2}
        let expectedResult13 = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26]
        
        assert(result1.elementsEqual(expectedResult1))
        assert(result2.elementsEqual(expectedResult2))
        assert(result3.elementsEqual(expectedResult3))
        assert(result4.elementsEqual(expectedResult4))
        assert(result5.elementsEqual(expectedResult5))
        assert(result6.elementsEqual(expectedResult6))
        assert(result7.elementsEqual(expectedResult7))
        assert(result8.elementsEqual(expectedResult8))
        assert(result9.elementsEqual(expectedResult9))
        assert(result10.elementsEqual(expectedResult10))
        assert(result11.elementsEqual(expectedResult11))
        assert(result12.elementsEqual(expectedResult12))
        assert(result13.elementsEqual(expectedResult13))
        print("正确性测试完成，已通过测试\n")
    }
}