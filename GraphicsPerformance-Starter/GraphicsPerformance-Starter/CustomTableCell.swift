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
