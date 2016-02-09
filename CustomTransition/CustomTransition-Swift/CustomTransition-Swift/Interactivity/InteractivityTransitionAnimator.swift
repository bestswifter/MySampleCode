//
//  InteractivityTransitionAnimator.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class InteractivityTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let targetEdge: UIRectEdge
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
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
        
        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        
        let fromFrame = transitionContext.initialFrameForViewController(fromViewController!)
        let toFrame = transitionContext.finalFrameForViewController(toViewController!)
        
        let offset: CGVector
        switch self.targetEdge {
        case UIRectEdge.Top: offset = CGVectorMake(0, 1)
        case UIRectEdge.Bottom: offset = CGVectorMake(0, -1)
        case UIRectEdge.Left: offset = CGVectorMake(1, 0)
        case UIRectEdge.Right: offset = CGVectorMake(-1, 0)
        default:fatalError("targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        }
        
        if isPresenting {
            // For a presentation, the toView starts off-screen and slides in.
            fromView?.frame = fromFrame
            toView?.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
                                                  toFrame.size.height * offset.dy * -1)
            containerView?.addSubview(toView!)
        } else {
            fromView?.frame = fromFrame
            toView?.frame = toFrame
            containerView?.insertSubview(toView!, belowSubview: fromView!)
        }
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            if isPresenting {
                toView?.frame = toFrame;
            } else {
                // For a dismissal, the fromView slides off the screen.
                fromView?.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
                    fromFrame.size.height * offset.dy);
            }
            }) { (finished: Bool) -> Void in
                let wasCanceled = transitionContext.transitionWasCancelled()
                if wasCanceled {toView?.removeFromSuperview()}
                transitionContext.completeTransition(!wasCanceled)
        }
    }
}
