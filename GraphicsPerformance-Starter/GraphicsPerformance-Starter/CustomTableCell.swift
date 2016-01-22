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
    let label = UILabel(frame: CGRectMake(220, 90, 150, 20))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView.layer.shadowColor = UIColor.blackColor().CGColor
        imgView.layer.shadowOpacity = 1
        imgView.layer.shadowRadius = 2
        imgView.layer.shadowOffset = CGSizeMake(1, 1)
        
        label.layer.shouldRasterize = true
        
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
