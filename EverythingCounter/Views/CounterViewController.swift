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
        }
    }
    var disposeBag = DisposeBag()
    
    func bind(reactor: CounterViewReactor) {    
        
        reactor.state
            .map { $0.counterNames }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(cellIdentifier: CounterCell.cellIdentifier, cellType: CounterCell.self)) { _, title, cell in
                cell.reactor = CounterCellReactor()
                cell.setTitle(title: title)
            }.disposed(by: disposeBag)
    }
}
