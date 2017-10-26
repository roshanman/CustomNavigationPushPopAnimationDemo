//
//  Animator.swift
//  CustomPushPopDemo
//
//  Created by morenotepad on 2017/10/25.
//  Copyright © morenotepad. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let toViewController  = transitionContext.viewController(forKey: .to),
            let fromViewController    = transitionContext.viewController(forKey: .from)
        else {
            return
        }
        
        let container = transitionContext.containerView
        let duration  = transitionDuration(using: transitionContext)
        
        container.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        UIView.animate(
            withDuration: duration,
            animations: {
                fromViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                toViewController.view.alpha = 1
            },
            completion: { finish in
                fromViewController.view.transform = CGAffineTransform.identity
                transitionContext.completeTransition(
                    !transitionContext.transitionWasCancelled
                )
            }
        )
    }
}


class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let toViewController  = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from)
        else {
            return
        }
        
        let container = transitionContext.containerView
        let duration  = transitionDuration(using: transitionContext)
        
        container.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        UIView.animate(
            withDuration: duration,
            animations: {
                toViewController.view.transform = CGAffineTransform.identity
                toViewController.view.alpha = 1
                fromViewController.view.alpha = 0
            },
            completion: { finish in
                fromViewController.view.transform = CGAffineTransform.identity
                transitionContext.completeTransition(
                    !transitionContext.transitionWasCancelled
                )
            }
        )
    }
}
