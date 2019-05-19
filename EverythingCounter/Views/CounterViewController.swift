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
    @IBOutlet weak var addCounterButton: UIButton!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- reactorがセットされたタイミングで呼ばれる
    func bind(reactor: CounterViewReactor) {
        
        reactor.state
            .map { $0.counters }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(cellIdentifier: CounterCell.cellIdentifier, cellType: CounterCell.self)) { _, counter, cell in
                cell.reactor = CounterCellReactor(counter: counter)
            }.disposed(by: disposeBag)
        
        addCounterButton.rx.tap
            .map { Reactor.Action.addCounter(title: "task") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
