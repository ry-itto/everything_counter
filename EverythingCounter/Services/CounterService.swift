//
//  CounterService.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/19.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

protocol CounterServiceProtocol {
    /// 全てのCounterを取得
    ///
    /// - Returns: 全てのCounter
    func findAll() -> [Counter]

    /// Counterを作成
    ///
    /// - Parameter title: Counterのタイトル
    func addCounter(title: String)

    /// Counterを更新.
    /// 値の増加だった場合：Countモデルを新規作成する
    /// 値の減少だった場合：最後に追加した紐づくCountモデルを削除する
    ///
    /// - Parameters:
    ///   - counter: Counter
    ///   - title: 更新後のタイトル(Optional)
    ///   - value: 更新後の値(Optional)
    /// - Returns: 更新後のCounter
    func update(_ counter: Counter, title: String?, value: Int?, type: CountType?) -> Counter

    /// Counterを削除.
    /// 同時に紐づくCountモデルも全て削除
    ///
    /// - Parameter counter: 削除対象のCounter
    func delete(_ counter: Counter)

    /// Counterのカウントをリセット
    ///
    /// - Parameter counter: リセット対象のCounter
    func resetCount(_ counter: Counter)
}

final class CounterService: CounterServiceProtocol {
    private let counterStore: CounterStoreProtocol
    private let countStore: CountStoreProtocol

    init(counterStore: CounterStoreProtocol = CounterStore.shared,
         countStore: CountStoreProtocol = CountStore.shared) {
        self.counterStore = counterStore
        self.countStore = countStore
    }

    func findAll() -> [Counter] {
        return counterStore.findAll()
    }

    func addCounter(title: String) {
        _ = counterStore.create(title: title)
    }

    func update(_ counter: Counter, title: String?, value: Int?, type: CountType?) -> Counter {
        let counter = counterStore.update(counter: counter, title: title, value: value)

        if let type = type {
            switch type {
            case .increase:
                _ = countStore.create(counter: counter, date: Date(), type: .increase)
            case .decrease:
                _ = countStore.deleteLast(counterID: counter.id)
            case .reset:
                _ = countStore.deleteAllByCounterID(counterID: counter.id)
            }
        }

        return counter
    }

    func delete(_ counter: Counter) {
        _ = countStore.deleteAllByCounterID(counterID: counter.id)
        counterStore.delete(counter: counter)
    }

    func resetCount(_ counter: Counter) {
        _ = counterStore.update(counter: counter, title: nil, value: 0)
        _ = countStore.deleteAllByCounterID(counterID: counter.id)
    }
}
