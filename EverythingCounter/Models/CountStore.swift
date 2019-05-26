//
//  CountStore.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

/// CountモデルのCRUD処理を行うクラス
final class CountStore {
    static let shared = CounterStore()
    private let realm = RealmManager.shared.realm
    
    /// DB上の全てのCountを取得
    ///
    /// - Returns: DB上の全てのCount
    func findAll() -> [Count] {
        return Array(realm.objects(Count.self))
    }
    
    /// CounterIDに紐づくDB上の全てのCountを取得
    ///
    /// - Parameter counterID: カウンターID
    /// - Returns: CounterIDに紐づくDB上の全てのCount
    func findByCounterID(counterID: String) -> [Count] {
        return realm.objects(Count.self).filter { count -> Bool in
            count.counterID == counterID
        }
    }
    
    /// 新規にCountを作成
    ///
    /// - Parameters:
    ///   - counter: 対象のカウンター
    ///   - date: カウントのアクションを起こした日
    ///   - type: カウントのアクションのタイプ
    /// - Returns: 作成したCount
    func create(counter: Counter, date: Date, type: CountType) -> Count {
        let count = Count()
        count.counterID = counter.id
        count.type = type.rawValue
        count.countDate = date
        do {
            try realm.write {
                realm.add(count)
            }
        } catch let e {
            print("\(#file)#\(#line) \"\(e.localizedDescription)\"")
        }
        return count
    }
}
