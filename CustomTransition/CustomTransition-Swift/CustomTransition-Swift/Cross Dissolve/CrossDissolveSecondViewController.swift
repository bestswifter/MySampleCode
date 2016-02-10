//
//  CrossDissolveSecondViewController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CrossDissolveSecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // 主要是一些UI控件的布局，可以无视其实现细节
    }
}

// MARK: - 处理UI控件的点击事件
extension CrossDissolveSecondViewController {
    func buttonDidClicked() {
        /**
        *  应该由FirstVC执行下面这行代码，为了保持demo简单，突出重点，这里的写法其实是不严格的，请见谅
        */
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - 对视图上的基本UI控件进行初始化，读者可以忽略
extension CrossDissolveSecondViewController {
    func setupView() {
        view.backgroundColor = [254, 223, 224].color    // 设置背景颜色
        
        /// 创建label
        let label = UILabel()
        label.text = "To"
        label.textAlignment = .Center
        label.font = UIFont(name: "Helvetica", size: 60)
        view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
        /// 创建button
        let button = UIButton()
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitle("Dismiss", forState: .Normal)
        button.addTarget(self, action: Selector("buttonDidClicked"), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }
}