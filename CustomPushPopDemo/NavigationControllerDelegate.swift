//
//  NavigationControllerDelegate.swift
//  CustomPushPopDemo
//
//  Created by morenotepad on 2017/10/25.
//  Copyright © morenotepad. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    let popAnimator  = PopAnimator()
    let pushAnimator = PushAnimator()
    var interactive: UIPercentDrivenInteractiveTransition!

    @IBOutlet weak var navigationController: UINavigationController! {
        didSet {
            let panGesture  = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handlePanGesutre(_:))
            )
            
            panGesture.edges = .left
            
            navigationController.view.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func handlePanGesutre(_ pan: UIScreenEdgePanGestureRecognizer) {
        
        guard let view = navigationController.view else {
            return
        }
        
        switch pan.state {
        case .began:
            if navigationController.viewControllers.count > 1 {
                interactive = UIPercentDrivenInteractiveTransition()
                navigationController.popViewController(animated: true)
            }
            
        case .changed:
            let translation = pan.translation(in: view).x
            let progress = translation / view.bounds.width
            
            interactive?.update(progress)
            
        case .ended:
            if pan.velocity(in: view).x > 0 {
                interactive?.finish()
            } else {
                interactive?.cancel()
            }
            interactive = nil
            
        case .cancelled:
            interactive = nil
            
        default:
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactive
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            return popAnimator
        case .push:
            return pushAnimator
        default:
            return nil
        }
    }
    
}
