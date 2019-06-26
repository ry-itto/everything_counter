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

    private let viewMargin: CGFloat = 30

    weak var semiModalPresentationController: SemiModalPresentationController?

    @IBOutlet weak var inputTitleField: UITextField! {
        didSet {
            inputTitleField.borderStyle = .none
            inputTitleField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var saveButton: UIButton!
    var disposeBag = DisposeBag()
    var onDismissed: (() -> Void)?

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
            .drive(Binder(self) { createCounterVC, frame in
                let height = frame.height
                    + createCounterVC.inputTitleField.frame.height
                    + createCounterVC.saveButton.frame.height
                    + createCounterVC.viewMargin
                createCounterVC.semiModalPresentationController?.setModalViewHeight(newHeight: height, animated: true)
            }).disposed(by: disposeBag)

        saveButton.rx.tap
            .filter { [weak self] in
                self?.inputTitleField.text.map { !$0.trimmingCharacters(in: [" "]).isEmpty } ?? false
            }
            .flatMap { [weak self] in
                self?.inputTitleField.text.map(Observable.just) ?? .empty()
            }.map { Reactor.Action.create(counterName: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // reactor state
        reactor.state
            .filter { $0.isCreated }
            .bind(to: Binder(self) { createCounterVC, _ in
                createCounterVC.presentingViewController?
                    .dismiss(animated: true, completion: createCounterVC.onDismissed)
            }).disposed(by: disposeBag)
    }
}
