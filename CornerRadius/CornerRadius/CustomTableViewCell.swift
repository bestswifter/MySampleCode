//
//  CustomTableViewCell.swift
//  CornerRadius
//
//  Created by 张星宇 on 16/2/27.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let imgView1 = UIImageView(frame: CGRect(x: 5, y: 10, width: 20, height: 21))
    let imgView2 = UIImageView(frame: CGRect(x: 55, y: 10, width: 20, height: 21))
    let view = UIView(frame: CGRect(x: 150, y: 10, width: 40, height: 21))
    let label = UILabel(frame: CGRect(x: 250, y: 10, width: 80, height: 21))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView1)
        self.contentView.addSubview(imgView2)

        view.backgroundColor = UIColor.brown
        view.layer.cornerRadius = 5
        
        self.contentView.addSubview(view)
        
        
//        label.kt_addCorner(radius: 8)
        label.layer.cornerRadius = 5
        label.text = "123"
        label.backgroundColor = UIColor.brown
        self.contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(imgName: String) {
        imgView1.image = UIImage(named: imgName)
        imgView2.image = UIImage(named: imgName)
        
        // 下面两行取消注释后试试
//        imgView1.kt_imageViewAddCorner(radius: 5)
//        imgView2.kt_imageViewAddCorner(radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
