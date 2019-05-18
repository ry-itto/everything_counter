//
//  CounterStore.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RealmSwift

/// CounterのDB情報にアクセス, 操作するクラス
final class CounterStore {
    
    static let shared = CounterStore()
    private let realm = RealmManager.shared.realm
    
    /// 新規にCounterを作成
    ///
    /// - Parameter title: Counterのタイトル
    /// - Returns: 作成したCounter
    func create(title: String) -> Counter {
        let counter = Counter()
        counter.title = title
        do {
            try realm.write {
                realm.add(counter)
            }
        } catch (let e) {
            print("\(#file)#\(#line) \"\(e.localizedDescription)\"")
        }
        return counter
    }
    
    /// Counterのタイトルを更新
    ///
    /// - Parameters:
    ///   - counter: 更新対象のCounter
    ///   - title: タイトル
    /// - Returns: 更新後のCounter
    func updateTitle(counter: Counter, title: String) -> Counter {
        do {
            try realm.write {
                counter.title = title
            }
        } catch (let e) {
            print("\(#file)#\(#line) \"\(e.localizedDescription)\"")
        }
        return counter
    }
    
    /// Counterの値を更新
    ///
    /// - Parameters:
    ///   - counter: 更新対象のCounter
    ///   - newValue: 更新したい値
    /// - Returns: 更新後のCounter
    func updateValue(counter: Counter, newValue: Int) -> Counter {
        do {
            try realm.write {
                counter.value = newValue
            }
        } catch (let e) {
            print("\(#file)#\(#line) \"\(e.localizedDescription)\"")
        }
        return counter
    }
}
