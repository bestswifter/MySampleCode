//
//  CustomTableViewCell.swift
//  CornerRadius
//
//  Created by 张星宇 on 16/2/27.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let imgView1 = UIImageView(frame: CGRectMake(5, 10, 20, 21))
    let imgView2 = UIImageView(frame: CGRectMake(55, 10, 20, 21))
    let view = UIView(frame: CGRectMake(150,10,40,21))
    let label = UILabel(frame: CGRectMake(250,10,80,21))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView1)
        self.contentView.addSubview(imgView2)

        view.backgroundColor = UIColor.brownColor()
        view.layer.cornerRadius = 5
        
        self.contentView.addSubview(view)
        
        
//        label.kt_addCorner(radius: 8)
        label.layer.cornerRadius = 5
        label.text = "123"
        label.backgroundColor = UIColor.brownColor()
        self.contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(imgName imgName: String) {
        imgView1.image = UIImage(named: imgName)
        imgView2.image = UIImage(named: imgName)
        
        // 下面两行取消注释后试试
//        imgView1.kt_addCorner(radius: 5)
//        imgView2.kt_addCorner(radius: 5)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
