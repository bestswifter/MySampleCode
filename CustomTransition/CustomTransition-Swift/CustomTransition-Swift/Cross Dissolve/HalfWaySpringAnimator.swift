//
//  HalfWaySpringAnimator.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class HalfWaySpringAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        var fromView = fromViewController?.view
        var toView = toViewController?.view
        
        if transitionContext.respondsToSelector(Selector("viewForKey:")) {
            fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        }
        
        fromView?.frame = transitionContext.initialFrameForViewController(fromViewController!)
        toView?.frame = CGRectMake(fromView!.frame.origin.x, fromView!.frame.maxY / 2, fromView!.frame.width, fromView!.frame.height)
        
        toView?.alpha = 0.0
        
        containerView?.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveLinear, animations: { () -> Void in
            toView!.alpha = 1.0
            toView?.frame = transitionContext.finalFrameForViewController(toViewController!)
            }) { (finished: Bool) -> Void in
                let wasCancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!wasCancelled)
        }
    }
}
