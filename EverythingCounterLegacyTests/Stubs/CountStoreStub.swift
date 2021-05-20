//
//  CountStoreStub.swift
//  EverythingCounterTests
//
//  Created by 伊藤凌也 on 2019/06/02.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
@testable import EverythingCounter

final class CountStoreStub: CountStoreProtocol {
    
    var counts: [Count]
    
    init(counts: [Count]) {
        self.counts = counts
    }
    
    func findAll() -> [Count] {
        return counts
    }
    
    func findByCounterID(counterID: String) -> [Count] {
        return counts.filter { (count) -> Bool in
            return count.counterID == counterID
        }
    }
    
    func create(counter: Counter, date: Date, type: CountType) -> Result<Count, Error> {
        let count = Count()
        count.countDate = date
        count.type = type.rawValue
        count.counterID = counter.id
        
        counts.append(count)
        return .success(count)
    }
    
    func deleteLast(counterID: String) -> Result<Count, Error> {
        return .success(counts.removeLast())
    }
    
    func deleteAllByCounterID(counterID: String) -> Result<Void, Error> {
        counts.removeAll { (count) -> Bool in
            return count.counterID == counterID
        }
        return .success(())
    }
}
