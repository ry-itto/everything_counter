//
//  CreateCounterViewController.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import ReactorKit

final class CreateCounterViewController: UIViewController, StoryboardView {
    
    private let viewMargin: CGFloat = 25
    
    var disposeBag = DisposeBag()
    
    weak var semiModalPresentationController: SemiModalPresentationController?
    
    @IBOutlet weak var inputTitleField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        semiModalPresentationController = self.presentationController as? SemiModalPresentationController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        semiModalPresentationController?.setModalViewHeight(newHeight: 200, animated: false)
    }
    
    func bind(reactor: CreateCounterViewReactor) {
        RxKeyboard.instance.frame
            .drive(Binder(self) { me, frame in
                let height = frame.height
                    + me.inputTitleField.frame.height
                    + me.saveButton.frame.height
                    + me.viewMargin
                me.semiModalPresentationController?.setModalViewHeight(newHeight: height, animated: true)
            }).disposed(by: disposeBag)
    }
}
