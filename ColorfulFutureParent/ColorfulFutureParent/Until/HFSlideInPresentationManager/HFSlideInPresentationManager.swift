//
//  HFSlideInPresentationManager.swift
//  MedalCount
//
//  Created by Warif Akhand Rishi on 10/18/16.
//  Copyright © 2016 Ron Kliffer. All rights reserved.
//
/*
 使用注意事项!
 使用注意事项!
 使用注意事项!
 
 实例对象需要作为控制器的全局变量使用，否则dismissal动画无效
 */

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class HFSlideInPresentationManager: NSObject {
    var direction = PresentationDirection.bottom
    var disableCompactHeight = false
    // 内容宽度
    var contentWidth = UIScreen.main.bounds.size.width * 2 / 3
    // 内容高度
    var contentHeight = UIScreen.main.bounds.size.width * 2 / 3
    // 进入时长
    var presentationDuration = 0.3
    // 退出时长
    var dismissalDuration = 0.3
}


// MARK: - UIViewControllerTransitioningDelegate
extension HFSlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = HFSlideInPresentationController(presentedViewController: presented,
                                                                     presenting: presenting,
                                                                     direction: direction)
        presentationController.contentWidth = contentWidth
        presentationController.contentHeight = contentHeight
        presentationController.delegate = self
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = HFSlideInPresentationAnimator(direction: direction, isPresentation: true)
        animator.presentationDuration = presentationDuration
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        let animator = HFSlideInPresentationAnimator(direction: direction, isPresentation: false)
        animator.dismissalDuration = dismissalDuration
        return animator
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension HFSlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }
    
    func presentationController(_ controller: UIPresentationController,
                                viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle)
    -> UIViewController? {
        guard style == .overFullScreen else { return nil }
        
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RotateViewController")
    }
}
