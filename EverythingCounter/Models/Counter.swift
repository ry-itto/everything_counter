//
//  Counter.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
import RealmSwift

final class Counter: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var value: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
