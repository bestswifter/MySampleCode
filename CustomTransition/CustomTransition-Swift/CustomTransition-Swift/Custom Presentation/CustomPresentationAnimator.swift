//
//  CustomPresentationAnimator.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/10.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class CustomPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if let isAnimated = transitionContext?.isAnimated() {
            return isAnimated ? 0.35 : 0
        }
        return 0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        
        var fromViewFinalFrame = transitionContext.finalFrameForViewController(fromViewController!)
        var toViewInitialFrame = transitionContext.initialFrameForViewController(toViewController!)
        let toViewFinalFrame = transitionContext.finalFrameForViewController(toViewController!)
        
        if toView != nil {
            containerView?.addSubview(toView!)
        }
        
        if isPresenting {
            toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView!.bounds), CGRectGetMaxY(containerView!.bounds))
            toViewInitialFrame.size = toViewFinalFrame.size
            toView?.frame = toViewInitialFrame
        } else {
            fromViewFinalFrame = CGRectOffset(fromView!.frame, 0, CGRectGetHeight(fromView!.frame))
        }
        
        let transitionDuration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(transitionDuration, animations: {
            if isPresenting {
                toView?.frame = toViewFinalFrame
            }
            else {
                fromView?.frame = fromViewFinalFrame
            }
            
            }) { (finished: Bool) -> Void in
                let wasCancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!wasCancelled)
        }
    }
}
