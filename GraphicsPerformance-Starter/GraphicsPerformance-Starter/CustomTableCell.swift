//
//  CustomTableCell.swift
//  GraphicsPerformance-Starter
//
//  Created by 张星宇 on 16/1/21.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    let imgView = UIImageView(frame: CGRect(x: 10, y: 10, width: 180, height: 180))
    let label = UILabel(frame: CGRect(x: 220, y: 90, width: 150, height: 20))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView.layer.shadowColor = UIColor.black.cgColor
        imgView.layer.shadowOpacity = 1
        imgView.layer.shadowRadius = 2
        imgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
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
