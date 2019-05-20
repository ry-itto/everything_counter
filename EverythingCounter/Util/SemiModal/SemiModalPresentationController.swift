//
//  SemiModalPresentationController.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit

class SemiModalPresentationController: UIPresentationController {
    
    private(set) var tapGestureRecognizer: UITapGestureRecognizer?
    private var overlayView = UIView()
    
    /// 呼び出し先ビューのframeを決定
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = containerView!.frame
        frame.origin.y = frame.height - self.modalViewHeight
        frame.size.height = self.modalViewHeight
        return frame
    }
    
    /// 外側をタップして閉じる
    var dismissesOnTappingOutside: Bool = true {
        didSet {
            self.tapGestureRecognizer?.isEnabled = self.dismissesOnTappingOutside
        }
    }
    
    private var modalViewHeight: CGFloat = 0
    
    func setModalViewHeight(newHeight: CGFloat, animated: Bool) {
        guard let presentedView = presentedView else { return }
        self.modalViewHeight = newHeight
        let frame = frameOfPresentedViewInContainerView
        
        if !animated {
            presentedView.frame = frame
            presentedView.layoutIfNeeded()
            return
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: {
                presentedView.frame = frame
                presentedView.layoutIfNeeded()
            },
            completion: nil)
    }
    
    private func setupOverlay(toContainerView: UIView) {
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnOverlay(_:)))
        self.tapGestureRecognizer!.isEnabled = self.dismissesOnTappingOutside
        
        self.overlayView.frame = toContainerView.bounds
        self.overlayView.backgroundColor = UIColor.black
        self.overlayView.alpha = 0.0
        self.overlayView.gestureRecognizers = [self.tapGestureRecognizer!]
        
        toContainerView.insertSubview(self.overlayView, at: 0)
    }
    
    private func setupPresentedView(presentedView: UIView) {
        presentedView.layer.cornerRadius = 15
        presentedView.clipsToBounds = true
    }
    
    /// 背景透過部分のタップで閉じる
    @objc private func tapOnOverlay(_ gesture: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true)
    }
    
    /// 表示直前
    override func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else {return}
        
        setupOverlay(toContainerView: containerView)
        setupPresentedView(presentedView: self.presentedView!)
        
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { [weak self] (context) in
                self?.overlayView.alpha = 0.35
            }, completion: nil)
    }
    
    /// 隠蔽直前
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { [weak self] (context) in
                self?.overlayView.alpha = 0.0
            }, completion: nil)
    }
    
    /// 隠蔽終了
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlayView.removeFromSuperview()
        }
    }
    
    /// ビューのレイアウト直前
    override func containerViewWillLayoutSubviews() {
        if let containerView = containerView {
            self.overlayView.frame = containerView.bounds
        }
        
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
}
