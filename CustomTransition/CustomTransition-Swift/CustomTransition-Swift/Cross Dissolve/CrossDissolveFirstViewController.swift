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
        view.backgroundColor = [224, 222, 255].color    // 设置背景颜色
        
        /// 设置navigationItem
        navigationItem.title = "淡入淡出"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("leftBarButtonDidClicked"))
        
        /// 创建label
        let label = UILabel(frame: CGRectMake(0,0,150,100))
        label.center = view.center
        label.text = "From"
        label.font = UIFont(name: "Helvetica", size: 60)
        view.addSubview(label)
        
        /// 创建button
        let button = UIButton(frame: CGRectMake(0,0,250,60))
        button.center = view.center
        button.frame.origin.y = view.frame.maxY - 100
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitle("演示动画", forState: .Normal)
        button.addTarget(self, action: Selector("animationButtonDidClicked"), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        /// 为了使用自定义present动画进行的一些设置
        crossDissolveSecondViewController.modalPresentationStyle = .FullScreen
        crossDissolveSecondViewController.transitioningDelegate = self;
    }
}

// MARK: - 实现UIViewControllerTransitioningDelegate协议
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

extension CrossDissolveFirstViewController {
    func animationButtonDidClicked() {
        self.presentViewController(crossDissolveSecondViewController, animated: true, completion: nil)
    }
    
    func leftBarButtonDidClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}