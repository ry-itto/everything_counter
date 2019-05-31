//
//  CounterViewController.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

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
            tableView.register(UINib(nibName: "CounterCell", bundle: nil), forCellReuseIdentifier: CounterCell.cellIdentifier)
            tableView.rowHeight = CounterCell.rowHeight
            tableView.tableFooterView = UIView()
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
    
    //MARK:- reactorがセットされたタイミングで呼ばれる
    func bind(reactor: CounterViewReactor) {
        
        let dataSource = CounterViewDataSource(reactor)
        /// reactor.state
        reactor.state
            .map { $0.counters }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        /// bind this view
        addCounterButton.rx.tap
            .bind(to: Binder(self) { me, _ in
                let createCounterVC = CreateCounterViewController()
                createCounterVC.reactor = CreateCounterViewReactor()
                createCounterVC.onDismissed = {
                    createCounterVC.resignFirstResponder()
                    Observable.just(Reactor.Action.reloadData)
                        .bind(to: reactor.action)
                        .disposed(by: createCounterVC.disposeBag)
                }
                me.presentSemiModal(createCounterVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Counter.self)
            .bind(to: Binder(self) { me, counter in
                let vc = CalendarViewController()
                vc.reactor = CalendarReactor(counterID: counter.id)
                me.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: Binder(self) { me, indexPath in
                me.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }
}
