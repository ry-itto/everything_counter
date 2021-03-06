//
//  CounterStore.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

protocol CounterStoreProtocol {
    /// DB上のCounterを全て取得
    ///
    /// - Returns: 全てのCounter
    func findAll() -> [Counter]

    /// 新規にCounterを作成
    ///
    /// - Parameter title: Counterのタイトル
    /// - Returns: 作成したCounter
    func create(title: String) -> Counter

    /// Counterのタイトルを更新
    ///
    /// - Parameters:
    ///   - counter: 更新対象のCounter
    ///   - title: タイトル
    /// - Returns: 更新後のCounter
    func update(counter: Counter, title: String?, value: Int?) -> Counter

    /// Counterを削除
    ///
    /// - Parameter counter: 削除対象のCounter
    func delete(counter: Counter)
}

/// CounterのDB情報にアクセス, 操作するクラス
final class CounterStore: CounterStoreProtocol {

    static let shared = CounterStore()
    private let realm = RealmManager.shared.realm

    func findAll() -> [Counter] {
        return Array(realm.objects(Counter.self))
    }

    func create(title: String) -> Counter {
        let counter = Counter()
        counter.title = title
        do {
            try realm.write {
                realm.add(counter)
            }
        } catch let err {
            print("\(#file)#\(#line) \"\(err.localizedDescription)\"")
        }
        return counter
    }

    func update(counter: Counter, title: String?, value: Int?) -> Counter {
        do {
            try realm.write {
                if let title = title {
                    counter.title = title
                }
                if let value = value {
                    counter.value = value
                }
            }
        } catch let err {
            print("\(#file)#\(#line) \"\(err.localizedDescription)\"")
        }
        return counter
    }

    func delete(counter: Counter) {
        do {
            try realm.write {
                realm.delete(counter)
            }
        } catch let err {
            print("\(#file)#\(#line) \"\(err.localizedDescription)\"")
        }
    }
}
