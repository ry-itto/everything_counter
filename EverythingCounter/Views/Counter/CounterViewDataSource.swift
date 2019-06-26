//
//  CounterViewDataSource.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/21.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RxSwift
import RxCocoa

final class CounterViewDataSource: NSObject,
    UITableViewDataSource, UITableViewDelegate, RxTableViewDataSourceType, SectionedViewDataSourceType {

    private let disposeBag = DisposeBag()
    private let reactor: CounterViewReactor

    typealias Element = [Counter]

    var items: [Counter] = []

    init(_ reactor: CounterViewReactor) {
        self.reactor = reactor
    }

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CounterCell.cellIdentifier, for: indexPath)
            as?  CounterCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.reactor = CounterCellReactor(counter: item)

        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal,
                                                                      title: "削除") { [weak self] (action, _) -> Void in
            guard let self = self else { return }
            let deleteItem = self.items[indexPath.row]
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            Observable.just(CounterViewReactor.Action.deleteCounter(counter: deleteItem))
                .bind(to: self.reactor.action)
                .disposed(by: self.disposeBag)
        }
        deleteButton.backgroundColor = UIColor.red

        return [deleteButton]
    }

    @available(iOS 11, *)
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? CounterCell,
            let reactor = cell.reactor
        else { return nil }

        let resetAction = UIContextualAction(style: .normal, title: "リセット") { [weak self] action, _, _ in
            guard let self = self else { return }
            Observable.just(CounterCellReactor.Action.reset)
                .bind(to: reactor.action)
                .disposed(by: self.disposeBag)
        }
        resetAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [resetAction])
        return configuration
    }

    // MARK: - RxTableViewDataSourceType
    func tableView(_ tableView: UITableView, observedEvent: Event<CounterViewDataSource.Element>) {
        Binder(self) { dataSource, element in
            dataSource.items = element
            tableView.reloadData()
        }.on(observedEvent)
    }

    // MARK: - SectionedViewDataSourceType
    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.row]
    }
}
