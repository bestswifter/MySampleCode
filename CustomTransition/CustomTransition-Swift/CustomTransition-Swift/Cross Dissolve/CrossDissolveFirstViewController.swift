//
//  CrossDissolveFirstViewController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/7.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CrossDissolveFirstViewController: UIViewController, UIViewControllerTransitioningDelegate {
    lazy var crossDissolveSecondViewController: CrossDissolveSecondViewController = CrossDissolveSecondViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // 主要是一些UI控件的布局，可以无视其实现细节
        
        /// 为了使用自定义present动画进行的一些设置
        crossDissolveSecondViewController.modalPresentationStyle = .FullScreen
        crossDissolveSecondViewController.transitioningDelegate = self  // 设置动画代理，这里的代理就是这个类自己
    }
}

// MARK: - 实现UIViewControllerTransitioningDelegate协议
// MARK: - 作为代理，需要提供present和dismiss时的animator，有时候一个animator可以同时在present和dismiss时用
extension CrossDissolveFirstViewController {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        也可以使用CrossDissolveAnimator，动画效果各有不同
//        return CrossDissolveAnimator()
        return HalfWaySpringAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator()
    }
}

// MARK: - 处理UI控件的点击事件
extension CrossDissolveFirstViewController {
    func animationButtonDidClicked() {
        self.presentViewController(crossDissolveSecondViewController, animated: true, completion: nil)
    }
    
    func leftBarButtonDidClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - 对视图上的基本UI控件进行初始化，读者可以忽略
extension CrossDissolveFirstViewController {
    func setupView() {
        view.backgroundColor = [224, 222, 255].color    // 设置背景颜色
        
        /// 设置navigationItem
        navigationItem.title = "淡入淡出"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("leftBarButtonDidClicked"))
        
        /// 创建label
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