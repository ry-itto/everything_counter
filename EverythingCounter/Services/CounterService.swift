//
//  CounterService.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/19.
//  Copyright © 2019 ry-itto. All rights reserved.
//

protocol CounterServiceProtocol {
    /// 全てのCounterを取得
    ///
    /// - Returns: 全てのCounter
    func findAll() -> [Counter]
    
    /// Counterを作成
    ///
    /// - Parameter title: Counterのタイトル
    func addCounter(title: String)
    
    /// Counterを更新
    ///
    /// - Parameters:
    ///   - counter: Counter
    ///   - title: 更新後のタイトル(Optional)
    ///   - value: 更新後の値(Optional)
    /// - Returns: 更新後のCounter
    func update(_ counter: Counter, title: String?, value: Int?) -> Counter
    
    /// Counterを削除
    ///
    /// - Parameter counter: 削除対象のCounter
    func delete(_ counter: Counter)
    
    /// Counterのカウントをリセット
    ///
    /// - Parameter counter: リセット対象のCounter
    func resetCount(_ counter: Counter)
}

final class CounterService: CounterServiceProtocol {
    private let store = CounterStore.shared
    
    func findAll() -> [Counter] {
        return store.findAll()
    }
    
    func addCounter(title: String) {
        _ = store.create(title: title)
    }
    
    func update(_ counter: Counter, title: String?, value: Int?) -> Counter {
        return store.update(counter: counter, title: title, value: value)
    }
    
    func delete(_ counter: Counter) {
        store.delete(counter: counter)
    }
    
    func resetCount(_ counter: Counter) {
        _ = store.update(counter: counter, title: nil, value: 0)
    }
}
