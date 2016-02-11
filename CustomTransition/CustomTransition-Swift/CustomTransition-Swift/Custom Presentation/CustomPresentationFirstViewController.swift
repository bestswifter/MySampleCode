//
//  CustomPresentationFirstViewController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/10.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomPresentationFirstViewController: UIViewController {
    lazy var customPresentationSecondViewController: CustomPresentationSecondViewController = CustomPresentationSecondViewController()
    lazy var customPresentationController: CustomPresentationController = CustomPresentationController(presentedViewController: self.customPresentationSecondViewController, presentingViewController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // 主要是一些UI控件的布局，可以无视其实现细节
        
        customPresentationSecondViewController.transitioningDelegate = customPresentationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UI事件处理
extension CustomPresentationFirstViewController {
    func animationButtonDidClicked() {
        self.presentViewController(customPresentationSecondViewController, animated: true, completion: nil)
    }
    
    func leftBarButtonDidClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - 对视图上的基本UI控件进行初始化，读者可以忽略
extension CustomPresentationFirstViewController {
    func setupView() {
        view.backgroundColor = [224, 222, 255].color    // 设置背景颜色
        
        /// 设置navigationItem
        navigationItem.title = "自定义Presentation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("leftBarButtonDidClicked"))
        
        // 创建label
        let label = UILabel()
        label.text = "From"
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
        button.setTitle("演示动画", forState: .Normal)
        button.addTarget(self, action: Selector("animationButtonDidClicked"), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }
}
