//
//  CounterStoreStub.swift
//  EverythingCounterTests
//
//  Created by 伊藤凌也 on 2019/06/02.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
@testable import EverythingCounter

final class CounterStoreStub: CounterStoreProtocol {
    
    var counters: [Counter]
    init(counters: [Counter]) {
        self.counters = counters
    }
    
    func findAll() -> [Counter] {
        return counters
    }
    
    func create(title: String) -> Counter {
        let counter = Counter()
        counter.title = title
        counter.value = 0
        
        counters.append(counter)
        
        return counter
    }
    
    func update(counter: Counter, title: String?, value: Int?) -> Counter {
        if let title = title {
            counter.title = title
        }
        
        if let value = value {
            counter.value = value
        }
        
        counters[counters.firstIndex(of: counter)!] = counter
        
        return counter
    }
    
    func delete(counter: Counter) {
        counters.remove(at: counters.firstIndex(of: counter)!)
    }
}
