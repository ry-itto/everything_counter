//
//  CounterViewDataSource.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/21.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RxSwift
import RxCocoa

final class CounterViewDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType, SectionedViewDataSourceType {
    
    private let disposeBag = DisposeBag()
    private let reactor: CounterViewReactor
    
    typealias Element = [Counter]
    
    var items: [Counter] = []
    
    init(_ reactor: CounterViewReactor) {
        self.reactor = reactor
    }
    
    // MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CounterCell.cellIdentifier, for: indexPath) as! CounterCell
        let item = items[indexPath.row]
        cell.reactor = CounterCellReactor(counter: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let deleteItem = items[indexPath.row]
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Observable.just(CounterViewReactor.Action.deleteCounter(counter: deleteItem))
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        default:
            break
        }
    }
    
    // MARK:- RxTableViewDataSourceType
    func tableView(_ tableView: UITableView, observedEvent: Event<CounterViewDataSource.Element>) {
        Binder(self) { me, element in
            me.items = element
            tableView.reloadData()
        }.on(observedEvent)
    }
    
    // MARK:- SectionedViewDataSourceType
    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.row]
    }
}
