//
//  Count.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/26.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
import RealmSwift

/// カウンターの値が変わる種別
///
/// - increase: 増加
/// - decrease: 減少
/// - reset: リセット
enum CountType: Int {
    case increase
    case decrease
    case reset
}
/// カウンターでカウントした日を記録するモデル
final class Count: Object {
    /// ID
    @objc dynamic var id: String = UUID().uuidString
    /// 対応するカウンターのID
    @objc dynamic var counterID: String = ""
    /// カウンターの値が変わった日
    @objc dynamic var countDate: Date = Date()
    /// カウンターの値が変わる種別
    /// enum CountType に種別が定義されています
    @objc dynamic var type: Int = CountType.increase.rawValue
    
    override static func primaryKey() -> String {
        return "id"
    }
}
