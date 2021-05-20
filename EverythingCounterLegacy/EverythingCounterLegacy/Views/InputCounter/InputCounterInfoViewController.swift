//
//  InputCounterInfoViewController.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxKeyboard
import RxSwift
import UIKit

enum InputMode {
    case create
    case edit(Counter)
    
    var title: String {
        switch self {
        case .create:
            return ""
        case .edit(let counter):
            return counter.title
        }
    }

    var inputPlaceHolder: String {
        switch self {
        case .create:
            return "新しいカウンター名"
        case .edit:
            return "カウンター名"
        }
    }

    var saveButtonLabel: String {
        switch self {
        case .create:
            return "登録"
        case .edit:
            return "更新"
        }
    }
}

final class InputCounterInfoViewController: UIViewController, StoryboardView {

    private let viewMargin: CGFloat = 30
    private let mode: InputMode

    weak var semiModalPresentationController: SemiModalPresentationController?

    @IBOutlet weak var inputTitleField: UITextField! {
        didSet {
            inputTitleField.placeholder = mode.inputPlaceHolder
            inputTitleField.text = mode.title
            inputTitleField.borderStyle = .none
            inputTitleField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle(mode.saveButtonLabel, for: .normal)
        }
    }
    var disposeBag = DisposeBag()
    var onDismissed: (() -> Void)?

    init(mode: InputMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        semiModalPresentationController = self.presentationController as? SemiModalPresentationController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        semiModalPresentationController?.setModalViewHeight(newHeight: 200, animated: false)
    }

    func bind(reactor: InputCounterInfoReactor) {
        RxKeyboard.instance.frame
            .drive(Binder(self) { inputCounterVC, frame in
                let height = frame.height
                    + inputCounterVC.inputTitleField.frame.height
                    + inputCounterVC.saveButton.frame.height
                    + inputCounterVC.viewMargin
                inputCounterVC.semiModalPresentationController?.setModalViewHeight(newHeight: height, animated: true)
            }).disposed(by: disposeBag)

        saveButton.rx.tap
            .filter { [weak self] in
                self?.inputTitleField.text.map { !$0.trimmingCharacters(in: [" "]).isEmpty } ?? false
            }
            .flatMap { [weak self] in
                self?.inputTitleField.text.map(Observable.just) ?? .empty()
            }
            .map { counterName -> Reactor.Action in
                switch self.mode {
                case .create:
                    return Reactor.Action.create(counterName: counterName)
                case .edit(let counter):
                    return Reactor.Action.edit(counter: counter, counterName: counterName)
                }
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // reactor state
        reactor.state
            .filter { $0.isEnded }
            .bind(to: Binder(self) { inputCounterVC, _ in
                inputCounterVC.presentingViewController?
                    .dismiss(animated: true, completion: inputCounterVC.onDismissed)
            }).disposed(by: disposeBag)
    }
}
