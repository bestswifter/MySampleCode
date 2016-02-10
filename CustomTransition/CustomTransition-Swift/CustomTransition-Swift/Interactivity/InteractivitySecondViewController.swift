//
//  InteractivitySecondViewController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class InteractivitySecondViewController: UIViewController {
    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: Selector("interactiveTransitionRecognizerAction:"))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // 主要是一些UI控件的布局，可以无视其实现细节
        
        /// 添加滑动交互手势
        interactiveTransitionRecognizer.edges = .Left
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 手势识别
extension InteractivitySecondViewController {
    func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Began {
            self.buttonDidClicked(sender)
        }
    }
}

// MARK: - 处理UI控件的点击事件
extension InteractivitySecondViewController {
    func buttonDidClicked(sender: AnyObject) {
        // 和FirstViewController中的代码是类似的，不过返回时手势应该是从左向右
        if let transitionDelegate = self.transitioningDelegate as? InteractivityTransitionDelegate {
            if sender.isKindOfClass(UIGestureRecognizer) {
                transitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
            }
            else {
                transitionDelegate.gestureRecognizer = nil
            }
            transitionDelegate.targetEdge = .Left
        }
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - 对视图上的基本UI控件进行初始化，读者可以忽略
extension InteractivitySecondViewController {
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
        button.addTarget(self, action: Selector("buttonDidClicked:"), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }
}
