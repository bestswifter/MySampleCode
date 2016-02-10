//
//  TransitionInteractionController.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class TransitionInteractionController: UIPercentDrivenInteractiveTransition {
    var transitionContext: UIViewControllerContextTransitioning? = nil
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer
    var edge: UIRectEdge
    
    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge) {
        assert(edge == .Top || edge == .Bottom || edge == .Left || edge == .Right,
            "edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        
        super.init()
        self.gestureRecognizer.addTarget(self, action: Selector("gestureRecognizeDidUpdate:"))
    }
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        super.startInteractiveTransition(transitionContext)
    }
    
    /**
     用于根据计算动画完成的百分比
     
     :param: gesture 当前的滑动手势，通过这个手势获取滑动的位移
     
     :returns: 返回动画完成的百分比
     */
    private func percentForGesture(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = transitionContext?.containerView()
        let locationInSourceView = gesture.locationInView(transitionContainerView)
        
        let width = transitionContainerView?.bounds.width
        let height = transitionContainerView?.bounds.height
        
        switch self.edge {
        case UIRectEdge.Right: return (width! - locationInSourceView.x) / width!
        case UIRectEdge.Left: return locationInSourceView.x / width!
        case UIRectEdge.Bottom: return (height! - locationInSourceView.y) / height!
        case UIRectEdge.Top: return locationInSourceView.y / height!
        default: return 0
        }
    }
    
    /// 当手势有滑动时触发这个函数
    func gestureRecognizeDidUpdate(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began: break
        case .Changed: self.updateInteractiveTransition(self.percentForGesture(gestureRecognizer))  //手势滑动，更新百分比
        case .Ended:    // 滑动结束，判断是否超过一半，如果是则完成剩下的动画，否则取消动画
            if self.percentForGesture(gestureRecognizer) >= 0.5 {
                self.finishInteractiveTransition()
            }
            else {
                self.cancelInteractiveTransition()
            }
        default: self.cancelInteractiveTransition()
        }
    }
}
