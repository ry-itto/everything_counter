//
//  RealmManager.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    static let shared: RealmManager = RealmManager()
    
    let realm: Realm
    
    private init() {
        self.realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
