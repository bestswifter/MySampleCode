//
//  InteractivityFirstViewController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class InteractivityFirstViewController: UIViewController {
    lazy var interactivitySecondViewController: InteractivitySecondViewController = InteractivitySecondViewController()
    lazy var customTransitionDelegate: InteractivityTransitionDelegate = InteractivityTransitionDelegate()
    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: Selector("interactiveTransitionRecognizerAction:"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = [224, 222, 255].color    // 设置背景颜色
        
        /// 设置navigationItem
        navigationItem.title = "交互式动画"
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
        button.addTarget(self, action: Selector("animationButtonDidClicked:"), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        /// 添加滑动交互手势
        interactiveTransitionRecognizer.edges = .Right;
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension InteractivityFirstViewController {
    func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Began {
            self.animationButtonDidClicked(sender)
        }
    }
}

extension InteractivityFirstViewController {
    func animationButtonDidClicked(sender: AnyObject) {
        /// 设置动画代理
        if sender.isKindOfClass(UIGestureRecognizer) {
            customTransitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
        }
        else {
            customTransitionDelegate.gestureRecognizer = nil
        }
        customTransitionDelegate.targetEdge = .Right
        interactivitySecondViewController.transitioningDelegate = customTransitionDelegate
        interactivitySecondViewController.modalPresentationStyle = .FullScreen
        
        self.presentViewController(interactivitySecondViewController, animated: true, completion: nil)
    }
    
    func leftBarButtonDidClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}