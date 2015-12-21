//
//  ViewController.swift
//  AutolayoutScrollViewInCode
//
//  Created by 张星宇 on 15/12/21.
//  Copyright © 2015年 张星宇. All rights reserved.
//

import UIKit
import SnapKit

let ScreenWidth = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height
let topScrollHeight: CGFloat = UIScreen.mainScreen().bounds.height / 3
let boxWidth: CGFloat = ScreenWidth * 2 / 3
let boxGap: CGFloat = 50

class ViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var containerView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        使用Container进行布局
        Use container in scrollview to layout subviews
        */
        
        /**
        使用外部视图进行布局
        Use views outside to locate subviews in scrollview
        */
//        layoutWithContainer()
        layoutWithAbsoluteView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
//        scrollView.contentSize = CGSizeMake(1000, topScrollHeight)
//        scrollView.contentSize.width = 1000
        print(scrollView.contentSize.width)
    }
}

// MARK: - 用Container实现自动布局
extension ViewController {
    func layoutWithContainer() {
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.yellowColor()
        scrollView.addSubview(containerView)
        
        containerView.backgroundColor = scrollView.backgroundColor
        
        scrollView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(view.snp_centerY)
            make.left.right.equalTo(view)
            make.height.equalTo(topScrollHeight)
        }
        
        containerView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(scrollView)
            make.height.equalTo(topScrollHeight)
        }
        
        for i in 0...5 {
            let box = UIView()
            box.backgroundColor = UIColor.redColor()
            containerView.addSubview(box)
            
            box.snp_makeConstraints(closure: { (make) -> Void in
                make.top.height.equalTo(containerView)
                make.width.equalTo(boxWidth)
                if i == 0 {
                    make.left.equalTo(containerView).offset(boxGap / 2)
                }
                else if let previousBox = containerView.subviews[i - 1] as? UIView{
                    make.left.equalTo(previousBox.snp_right).offset(boxGap)
                }
                if i == 5 {
                    containerView.snp_makeConstraints(closure: { (make) -> Void in
                        make.right.equalTo(box)
                    })
                }
            })
        }
    }
}

extension ViewController {
    func layoutWithAbsoluteView() {
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.yellowColor()
        
        scrollView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(view.snp_centerY)
            make.left.right.equalTo(view)
            make.height.equalTo(topScrollHeight)
        }
        
        for i in 0...5 {
            let box = UIView()
            box.backgroundColor = UIColor.redColor()
            scrollView.addSubview(box)
            
            box.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(0)
                make.bottom.equalTo(view).offset(-(ScreenHeight - topScrollHeight) / 2)  // This bottom can be incorret when device is rotated
                make.height.equalTo(topScrollHeight)
                
                make.width.equalTo(boxWidth)
                if i == 0 {
                    make.left.equalTo(boxGap / 2)
                }
                else if let previousBox = scrollView.subviews[i - 1] as? UIView{
                    make.left.equalTo(previousBox.snp_right).offset(boxGap)
                }
                
                if i == 5 {
                    make.right.equalTo(scrollView)
                }
            })
        }
    }
}




