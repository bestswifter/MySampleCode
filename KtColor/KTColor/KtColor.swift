//
//  KtColor.swift
//  KTColor
//
//  Created by 张星宇 on 16/2/18.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 为字符串提供计算属性：ktcolor，根据字符串创建UIColor对象
extension String {
    func split(seperator: Character) -> Array<String> {
        return characters.split{ $0 == seperator}.map { String($0) }
    }
    
    func split(seperator: String) -> Array<String> {
        return characters.split(seperator.characters).map { String($0) }
    }
    
    public var ktcolor: UIColor {
        return ColorParser.colorFromString(self)
    }
}

extension CollectionType where Generator.Element: Equatable {
    func split<S: SequenceType where Generator.Element == S.Generator.Element>
        (seperators: S) -> [SubSequence] {
            return split { seperators.contains($0) }
    }
}

/**
 *  负责字符串处理的内部结构体
 */
private struct ColorParser {
    /**
     *  从16进制（字母大写）转换成十进制
     *
     *  @return 十进制整数
     */
    private static func intFromHex(var hex: String) -> Int {
        var sum = 0
        hex = hex.uppercaseString
        for scalar in hex.unicodeScalars {
            let asciiValue = Int(scalar.value)
            let n: Int = asciiValue >= 65 ? asciiValue - 55 : asciiValue - 48
            sum = sum * 16 + n
        }
        return sum
    }
    
    /**
     将字符串数组转换为UIColor对象
     
     :param: colors 数组格式为["12", "34", "56", ("1")]，第四个元素如果缺失，默认为1
     
     :returns: UIColor颜色对象
     */
    private static func colorFromStringImpl(colors: Array<String>) -> UIColor {
        let nums = colors.flatMap{ Int($0) }
        let alpha = colors.count == 4 ? CGFloat(Double(colors[3]) ?? 1) : 1
        let floats = nums.map{ CGFloat($0) }
        
        return UIColor(red: floats[0]/255.0, green: floats[1]/255.0, blue: floats[2]/255.0, alpha: alpha)
    }
    
    /**
     根据字符串字面量创建UIColor对象
     
     :param: colorLiteral 字符串字面量，可以是十六进制数字："#DC143C"、"#ff69b4"，不区分大小写
     可以是数组形式，如"111 222 223"、"111,222,223,1"、"111, 222, 223, 0.5"，支持多种分隔符，默认alpha为1
     可以是颜色的英文名称，如"Orchid"、"Purple"、"LightPink"、"DarkSeaGreen"等
     完整列表可以参考：http://www.w3school.com.cn/cssref/css_colorsfull.asp
     :returns: UIColor对象，如果格式不支持，则返回默认颜色：白色
     */
    static func colorFromString(var colorLiteral: String) -> UIColor {
        if let hexString = colorHexDictionary[colorLiteral] {
            colorLiteral = hexString
        }
        if colorLiteral.characters.startsWith(["#"]) {
            var red, green, blue: Int
            red = intFromHex(String(colorLiteral.characters.dropFirst().prefix(2)))
            green = intFromHex(String(colorLiteral.characters.dropFirst(3).prefix(2)))
            blue = intFromHex(String(colorLiteral.characters.dropFirst(5).prefix(2)))
            return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
        }
        else {
            let numsInString1 = colorLiteral.split(", ")
            if numsInString1.count == 3 || numsInString1.count == 4 { return colorFromStringImpl(numsInString1) }
            
            let numsInString2 = colorLiteral.split(",")
            if numsInString2.count == 3 || numsInString2.count == 4 { return colorFromStringImpl(numsInString2) }
            
            let numsInString3 = colorLiteral.split(" ")
            if numsInString3.count == 3 || numsInString3.count == 4 { return colorFromStringImpl(numsInString3) }
            else { return UIColor.whiteColor() }
        }
    }
    
    private static let colorHexDictionary: [String: String] = [
        "LightPink": "#FFB6C1", "Pink": "#FFC0CB", "Crimson": "#DC143C", "LavenderBlush": "#FFF0F5",
        "PaleVioletRed": "#DB7093", "HotPink": "#FF69B4","DeepPink": "#FF1493", "MediumVioletRed": "#C71585",
        "Orchid": "#DA70D6", "Thistle": "#D8BFD8", "plum": "#DDA0DD", "Violet": "#EE82EE", "Magenta": "#FF00FF",
        "Fuchsia": "#FF00FF", "DarkMagenta": "#8B008B", "Purple": "#800080", "MediumOrchid": "#BA55D3",
        "DarkVoilet": "#9400D3", "DarkOrchid": "#9932CC", "Indigo": "#4B0082", "BlueViolet": "#8A2BE2",
        "MediumPurple": "#9370DB", "MediumSlateBlue": "#7B68EE", "SlateBlue": "#6A5ACD", "DarkSlateBlue": "#483D8B",
        "Lavender": "#E6E6FA", "GhostWhite": "#F8F8FF", "Blue": "#0000FF", "MediumBlue": "#0000CD", "MidnightBlue": "#191970",
        "DarkBlue": "#00008B", "Navy": "#000080", "RoyalBlue": "#4169E1", "CornflowerBlue": "#6495ED",
        "LightSteelBlue": "#B0C4DE", "LightSlateGray": "#778899", "SlateGray": "#708090", "DoderBlue": "#1E90FF",
        "AliceBlue": "#F0F8FF", "SteelBlue": "#4682B4", "LightSkyBlue": "#87CEFA", "SkyBlue": "#87CEEB",
        "DeepSkyBlue": "#00BFFF", "LightBLue": "#ADD8E6", "PowDerBlue": "#B0E0E6", "CadetBlue": "#5F9EA0","Azure": "#F0FFFF",
        "LightCyan": "#E1FFFF", "PaleTurquoise": "#AFEEEE", "Cyan": "#00FFFF", "Aqua": "#00FFFF", "DarkTurquoise": "#00CED1",
        "DarkSlateGray": "#2F4F4F", "DarkCyan": "#008B8B", "Teal": "#008080", "MediumTurquoise": "#48D1CC",
        "LightSeaGreen": "#20B2AA", "Turquoise": "#40E0D0", "Auqamarin": "#7FFFAA", "MediumAquamarine": "00FA9A#",
        "MediumSpringGreen": "#F5FFFA", "MintCream": "#00FF7F", "SpringGreen": "#3CB371", "SeaGreen": "#2E8B57",
        "Honeydew": "#F0FFF0", "LightGreen": "#90EE90", "PaleGreen": "#98FB98", "DarkSeaGreen": "#8FBC8F", "LimeGreen": "#32CD32",
        "Lime": "#00FF00", "ForestGreen": "#228B22", "Green": "#008000", "DarkGreen": "#006400", "Chartreuse": "#7FFF00",
        "LawnGreen": "#7CFC00", "GreenYellow": "#ADFF2F", "OliveDrab": "#556B2F", "Beige": "#6B8E23",
        "LightGoldenrodYellow": "#FAFAD2", "Ivory": "#FFFFF0", "LightYellow": "#FFFFE0", "Yellow": "#FFFF00", "Olive": "#808000",
        "DarkKhaki": "#BDB76B", "LemonChiffon": "#FFFACD", "PaleGodenrod": "#EEE8AA", "Khaki": "#F0E68C", "Gold": "#FFD700",
        "Cornislk": "#FFF8DC", "GoldEnrod": "#DAA520", "FloralWhite": "#FFFAF0", "OldLace": "#FDF5E6", "Wheat": "#F5DEB3",
        "Moccasin": "#FFE4B5", "Orange": "#FFA500", "PapayaWhip": "#FFEFD5", "BlanchedAlmond": "#FFEBCD",
        "NavajoWhite": "#FFDEAD", "AntiqueWhite": "#FAEBD7", "Tan": "#D2B48C", "BrulyWood": "#DEB887", "Bisque": "#FFE4C4",
        "DarkOrange": "#FF8C00", "Linen": "#FAF0E6", "Peru": "#CD853F", "PeachPuff": "#FFDAB9", "SandyBrown": "#F4A460",
        "Chocolate": "#D2691E", "SaddleBrown": "#8B4513", "SeaShell": "#FFF5EE", "Sienna": "#A0522D", "LightSalmon": "#FFA07A",
        "Coral": "#FF7F50", "OrangeRed": "#FF4500", "DarkSalmon": "#E9967A", "Tomato": "#FF6347", "MistyRose": "#FFE4E1",
        "Salmon": "#FA8072", "Snow": "#FFFAFA", "LightCoral": "#F08080", "RosyBrown": "#BC8F8F", "IndianRed": "#CD5C5C",
        "Red": "#FF0000", "Brown": "#A52A2A", "FireBrick": "#B22222", "DarkRed": "#8B0000", "Maroon": "#800000",
        "White": "#FFFFFF", "WhiteSmoke": "#F5F5F5", "Gainsboro": "#DCDCDC", "LightGrey": "#D3D3D3", "Silver": "#C0C0C0",
        "DarkGray": "#A9A9A9", "Gray": "#808080", "DimGray": "#696969", "Black": "#000000"
    ]
}