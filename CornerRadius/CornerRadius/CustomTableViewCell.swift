//
//  CustomTableViewCell.swift
//  CornerRadius
//
//  Created by 张星宇 on 16/2/27.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let imgView1 = UIImageView(frame: CGRectMake(20, 20, 60, 60))
    let imgView2 = UIImageView(frame: CGRectMake(100, 20, 60, 60))
    let imgView3 = UIImageView(frame: CGRectMake(180, 20, 60, 60))
    let imgView4 = UIImageView(frame: CGRectMake(260, 20, 60, 60))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView1.layer.cornerRadius = 30
        imgView1.layer.masksToBounds = true
        
        imgView2.layer.cornerRadius = 30
        imgView2.layer.masksToBounds = true
        
        imgView3.layer.cornerRadius = 30
        imgView3.layer.masksToBounds = true
        
        imgView4.layer.cornerRadius = 30
        imgView4.layer.masksToBounds = true
        
        self.contentView.addSubview(imgView1)
        self.contentView.addSubview(imgView2)
        self.contentView.addSubview(imgView3)
        self.contentView.addSubview(imgView4)
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
        imgView3.image = UIImage(named: imgName)
        imgView4.image = UIImage(named: imgName)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
