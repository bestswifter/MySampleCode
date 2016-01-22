//
//  CustomTableCell.swift
//  GraphicsPerformance-Starter
//
//  Created by 张星宇 on 16/1/21.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    let imgView = UIImageView(frame: CGRectMake(10, 10, 180, 180))
    let label = UILabel(frame: CGRectMake(250, 90, 100, 20))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        label.layer.shouldRasterize = true
//        imgView.layer.shadowColor = UIColor.blackColor().CGColor
//        imgView.layer.shadowOpacity = 1
//        imgView.layer.shadowRadius = 2
//        imgView.layer.shadowOffset = CGSizeMake(1, 1)
//        // 不加下面这句，Core Animation 会计算阴影形状,这需要离屏渲染，touch上fps掉到30
//        imgView.layer.shadowPath = UIBezierPath(rect: imgView.bounds).CGPath
        
        
//        label.backgroundColor = UIColor.whiteColor() // 不加这一行就会有blended layer
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(label)
    }
    
    func setupContent(imgName: String, text: String) {
        imgView.image = UIImage(named: imgName)
        label.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
