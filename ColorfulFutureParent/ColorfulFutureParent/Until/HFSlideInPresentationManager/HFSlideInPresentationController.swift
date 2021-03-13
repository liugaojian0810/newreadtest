//
//  HFSlideInPresentationController.swift
//  MedalCount
//
//  Created by Warif Akhand Rishi on 10/18/16.
//  Copyright © 2016 Ron Kliffer. All rights reserved.
//

import UIKit

class HFSlideInPresentationController: UIPresentationController {
    
    //1
    // MARK: - Properties
    fileprivate var dimmingView: UIView!
    private var direction: PresentationDirection
    var contentWidth = UIScreen.main.bounds.size.width * 2 / 3
    var contentHeight = UIScreen.main.bounds.size.width * 2 / 3
    
    //2
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection) {
        self.direction = direction
        
        //3
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func presentationTransitionWillBegin() {
        
        // 1
        containerView?.insertSubview(dimmingView, at: 0)
        
        // 2
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        
        //3
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: contentWidth, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: contentHeight)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        //1
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        
        //2
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width - contentWidth
        case .bottom:
            frame.origin.y = containerView!.frame.height - contentHeight
        default:
            frame.origin = .zero
        }
        return frame
    }
}

// MARK: - Private
private extension HFSlideInPresentationController {
    
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
