//
//  CounterServiceTest.swift
//  EverythingCounterTests
//
//  Created by 伊藤凌也 on 2019/06/02.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import XCTest
@testable import EverythingCounter

class CounterServiceTest: XCTestCase {
    /// 正常にカウンターが全て取得できること
    func testFindAll() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        
        // 実行
        let service = CounterService(counterStore: CounterStoreStub(counters: [counter1, counter2, counter3]))
        let result = service.findAll()
        
        // 検証
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], counter1)
        XCTAssertEqual(result[1], counter2)
        XCTAssertEqual(result[2], counter3)
    }
    
    /// 正常にカウンターが追加できること
    func testAddCounter() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub)
        service.addCounter(title: "test")
        
        // 検証
        XCTAssertEqual(counterStoreStub.counters.last?.title, "test")
    }
    
    /// タイトルが更新できること
    func testUpdate_updateTitle() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let countStoreStub = CountStoreStub(counts: [])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        let result = service.update(counter1, title: "Test", value: nil, type: nil)
        
        // 検証
        XCTAssertEqual(result.id, counter1.id)
        XCTAssertEqual(result.title, "Test")
        XCTAssertEqual(result.value, counter1.value)
    }
    
    /// 値が更新できること
    func testUpdate_updateValueIncrease() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let countStoreStub = CountStoreStub(counts: [])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        let result = service.update(counter1, title: nil, value: 10, type: .increase)
        
        // 検証
        XCTAssertEqual(result.id, counter1.id)
        XCTAssertEqual(result.title, counter1.title)
        XCTAssertEqual(result.value, 10)
        XCTAssertEqual(countStoreStub.counts.count, 1)
        XCTAssertEqual(countStoreStub.counts[0].counterID, counter1.id)
        XCTAssertEqual(countStoreStub.counts[0].type, CountType.increase.rawValue)
    }
    
    /// 値が更新できること
    func testUpdate_updateValueDecrease() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let count = Count()
        let countStoreStub = CountStoreStub(counts: [count])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        let result = service.update(counter2, title: nil, value: 10, type: .decrease)
        
        // 検証
        XCTAssertEqual(result.id, counter2.id)
        XCTAssertEqual(result.title, counter2.title)
        XCTAssertEqual(result.value, 10)
        XCTAssertEqual(countStoreStub.counts.count, 0)
    }
    
    /// 値が更新できること
    func testUpdate_updateValueReset() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let count = Count()
        count.counterID = counter3.id
        let countStoreStub = CountStoreStub(counts: [count, count, count, count])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        let result = service.update(counter3, title: nil, value: 0, type: .reset)
        
        // 検証
        XCTAssertEqual(result.id, counter3.id)
        XCTAssertEqual(result.title, counter3.title)
        XCTAssertEqual(result.value, 0)
        XCTAssertEqual(countStoreStub.counts.count, 0)
    }
    
    /// 正常にカウンターが削除されること
    func testDelete() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let count = Count()
        count.counterID = counter3.id
        let countStoreStub = CountStoreStub(counts: [count, count, count, count])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        service.delete(counter3)
        
        // 検証
        XCTAssertEqual(counterStoreStub.counters.count, 2)
        XCTAssertFalse(counterStoreStub.counters.contains(counter3))
        XCTAssertEqual(countStoreStub.counts.count, 0)
    }
    
    /// 指定したカウンターのみ削除されること
    func testDelete_onlySpecified() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let count = Count()
        count.counterID = counter2.id
        let countStoreStub = CountStoreStub(counts: [count, count, count, count])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        service.delete(counter3)
        
        // 検証
        XCTAssertEqual(counterStoreStub.counters.count, 2)
        XCTAssertFalse(counterStoreStub.counters.contains(counter3))
        XCTAssertEqual(countStoreStub.counts.count, 4)
    }
    
    /// カウントのリセットとそれに紐づくカウントモデルが削除されること
    func testReset() {
        // データ作成
        let counter1 = Counter()
        counter1.title = "test"
        counter1.value = 0
        let counter2 = Counter()
        counter2.title = "hoge"
        counter2.value = 123
        let counter3 = Counter()
        counter3.title = "fuga"
        counter3.value = 12345
        let counterStoreStub = CounterStoreStub(counters: [counter1, counter2, counter3])
        let count = Count()
        count.counterID = counter2.id
        let countStoreStub = CountStoreStub(counts: [count, count, count, count])
        
        // 実行
        let service = CounterService(counterStore: counterStoreStub, countStore: countStoreStub)
        service.resetCount(counter2)
        
        // 検証
        XCTAssertEqual(counterStoreStub.counters.count, 3)
        XCTAssertEqual(counterStoreStub.counters[1].value, 0)
        XCTAssertEqual(countStoreStub.counts.count, 0)
    }
}
