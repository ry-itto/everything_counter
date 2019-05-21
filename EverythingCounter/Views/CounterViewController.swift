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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CounterCell", bundle: nil), forCellReuseIdentifier: CounterCell.cellIdentifier)
            tableView.rowHeight = CounterCell.rowHeight
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var addCounterButton: UIButton! {
        didSet {
            addCounterButton.layer.cornerRadius = addCounterButton.frame.height / 2
            addCounterButton.clipsToBounds = true
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
                    Observable.just(Reactor.Action.reloadData)
                        .bind(to: reactor.action)
                        .disposed(by: createCounterVC.disposeBag)
                }
                me.presentSemiModal(createCounterVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        // table view
        tableView.rx.itemSelected
            .bind(to: Binder(self) { me, indexPath in
                me.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }
}
