//
//  CountStore.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

protocol CountStoreProtocol {
    /// DB上の全てのCountを取得
    ///
    /// - Returns: DB上の全てのCount
    func findAll() -> [Count]

    /// CounterIDに紐づくDB上の全てのCountを取得
    ///
    /// - Parameter counterID: カウンターID
    /// - Returns: CounterIDに紐づくDB上の全てのCount
    func findByCounterID(counterID: String) -> [Count]
    /// 新規にCountを作成
    ///
    /// - Parameters:
    ///   - counter: 対象のカウンター
    ///   - date: カウントのアクションを起こした日
    ///   - type: カウントのアクションのタイプ
    /// - Returns: 作成したCount
    func create(counter: Counter, date: Date, type: CountType) -> Result<Count, Error>
    /// CounterIDに紐づく最後に作成したモデルを削除
    ///
    /// - Parameter counterID: カウンターID
    /// - Returns: 削除したCount
    func deleteLast(counterID: String) -> Result<Count, Error>
    /// CounterIDに紐づく全てのCountモデルを削除
    ///
    /// - Parameter counterID: カウンターID
    /// - Returns: 結果
    func deleteAllByCounterID(counterID: String) -> Result<Void, Error>
}

/// CountモデルのCRUD処理を行うクラス
final class CountStore: CountStoreProtocol {
    static let shared = CountStore()
    private let realm = RealmManager.shared.realm
    func findAll() -> [Count] {
        return Array(realm.objects(Count.self))
    }
    func findByCounterID(counterID: String) -> [Count] {
        return realm.objects(Count.self).filter { count -> Bool in
            count.counterID == counterID
        }
    }
    func create(counter: Counter, date: Date, type: CountType) -> Result<Count, Error> {
        let count = Count()
        count.counterID = counter.id
        count.type = type.rawValue
        count.countDate = date
        do {
            try realm.write {
                realm.add(count)
            }
        } catch let err {
            print("\(#file)#\(#line) \"\(err.localizedDescription)\"")
            return .failure(err)
        }
        return .success(count)
    }
    func deleteLast(counterID: String) -> Result<Count, Error> {
        let objects: [Count] = realm.objects(Count.self).filter { count -> Bool in
            return count.counterID == counterID
        }
        guard let deleteTarget = objects.last else {
            return .failure(RealmError.notFound)
        }
        do {
            try realm.write {
                realm.delete(deleteTarget)
            }
        } catch let err {
            print("\(#file)#\(#line) \"\(err.localizedDescription)\"")
            return .failure(err)
        }
        return .success(deleteTarget)
    }

    func deleteAllByCounterID(counterID: String) -> Result<Void, Error> {
        let objects: [Count] = realm.objects(Count.self).filter { count -> Bool in
            return count.counterID == counterID
        }
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch let err {
            print("\(#file)#\(#line) \"\(err.localizedDescription)\"")
            return .failure(err)
        }
        return .success(())
    }
}
