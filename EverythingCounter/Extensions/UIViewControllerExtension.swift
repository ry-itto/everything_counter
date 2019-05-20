//
//  UIViewControllerExtension.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit

// MARK:- SemiModal Extension
extension UIViewController: UIViewControllerTransitioningDelegate {
    /// セミモーダルでビューを表示する.
    /// 使う前にpresentationController#setModalHeightメソッドを呼び、モーダル の高さを指定する.
    ///
    /// - Parameters:
    ///   - vc: The view controller to display over the current view controller’s content.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
    func presentSemiModal(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: animated, completion: completion)
    }
    
    // delegate method
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let semiModalPresentationController = SemiModalPresentationController(presentedViewController: presented, presenting: presenting)
        semiModalPresentationController.dismissesOnTappingOutside = true
        return semiModalPresentationController
    }
}
