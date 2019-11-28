//
//  CounterViewController.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

final class CounterViewController: UIViewController, StoryboardView {

    @IBOutlet weak var headerView: UIView! {
        didSet {
            // 影の設定
            headerView.layer.shadowColor = UIColor.black.cgColor
            headerView.layer.shadowOffset = CGSize(width: 0, height: 0.3)
            headerView.layer.shadowOpacity = 0.05
            headerView.layer.shadowRadius = 10
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CounterCell", bundle: nil),
                               forCellReuseIdentifier: CounterCell.cellIdentifier)
            tableView.rowHeight = CounterCell.rowHeight
            tableView.tableFooterView = UIView()
            let footerHeight = UIScreen.main.bounds.height - addCounterButton.frame.minY
            tableView.tableFooterView?.frame.size.height = footerHeight
//            tableView.allowsSelection = false
        }
    }
    @IBOutlet weak var addCounterButton: UIButton! {
        didSet {
            addCounterButton.backgroundColor = UIColor.Nippon.byakugun.color()
            addCounterButton.layer.cornerRadius = addCounterButton.bounds.midY
            // 影の設定
            addCounterButton.layer.shadowColor = UIColor.black.cgColor
            addCounterButton.layer.shadowOffset = CGSize(width: 0, height: 3)
            addCounterButton.layer.shadowOpacity = 0.5
            addCounterButton.layer.shadowRadius = 10
        }
    }
    var disposeBag = DisposeBag()

    // MARK: - reactorがセットされたタイミングで呼ばれる
    func bind(reactor: CounterViewReactor) {

        let longPressAction: (Counter) -> Void = { [weak self] counter in
            let editCounterVC = InputCounterInfoViewController(mode: .edit(counter))
            editCounterVC.reactor = InputCounterInfoReactor()
            editCounterVC.onDismissed = {
                editCounterVC.resignFirstResponder()
                Observable.just(Reactor.Action.reloadData)
                    .bind(to: reactor.action)
                    .disposed(by: editCounterVC.disposeBag)
            }
            self?.presentSemiModal(editCounterVC, animated: true, completion: nil)
        }

        let dataSource = CounterViewDataSource(reactor, longPressAction: longPressAction)
        _ = tableView.rx.setDelegate(dataSource)

        /// reactor.state
        reactor.state
            .map { $0.counters }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        /// bind this view
        addCounterButton.rx.tap
            .bind(to: Binder(self) { counterVC, _ in
                let createCounterVC = InputCounterInfoViewController(mode: .create)
                createCounterVC.reactor = InputCounterInfoReactor()
                createCounterVC.onDismissed = {
                    createCounterVC.resignFirstResponder()
                    Observable.just(Reactor.Action.reloadData)
                        .bind(to: reactor.action)
                        .disposed(by: createCounterVC.disposeBag)
                }
                counterVC.presentSemiModal(createCounterVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)

        tableView.rx.modelSelected(Counter.self)
            .bind(to: Binder(self) { counterVC, counter in
                let calendarVC = CalendarViewController()
                calendarVC.reactor = CalendarReactor(counterID: counter.id)
                counterVC.present(calendarVC, animated: true)
            }).disposed(by: disposeBag)

        tableView.rx.itemSelected
            .bind(to: Binder(self) { counterVC, indexPath in
                counterVC.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }
}
