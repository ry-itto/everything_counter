//
//  CalendarServiceTest.swift
//  EverythingCounterTests
//
//  Created by 伊藤凌也 on 2019/06/02.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import XCTest
import RealmSwift
@testable import EverythingCounter

class CalendarServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// カレンダーが正常に生成されること
    func testGenerateCalendar_Success() {
        // データ作成
        let year = 2019
        let month = 6
        let counterID = UUID().uuidString
        
        // 実行
        let service = CalendarService(CountStoreStub(counts: []))
        let result = service.generateCalendar(year: year, month: month, counterID: counterID)
        
        // 検証
        XCTAssertEqual(result.count, 30)
        XCTAssertEqual(result[0].month, month)
        XCTAssertEqual(result[0].dayOfWeek, 6)
        XCTAssertEqual(result[0].day, 1)
        XCTAssertEqual(result[0].dayOfWeekStr, "土")
    }
    
    /// カレンダーが正常に生成されること
    /// カウントされた日にフラグが立っていること
    func testGenerateCalendar_SuccessCounted() {
        // データ作成
        let today = Date()
        let year = Calendar.current.component(.year, from: today)
        let month = Calendar.current.component(.month, from: today)
        let day = Calendar.current.component(.day, from: today)
        let counterID = UUID().uuidString
        let count = Count()
        count.countDate = today
        count.type = CountType.increase.rawValue
        count.counterID = counterID
        
        // 実行
        let service = CalendarService(CountStoreStub(counts: [count]))
        let result = service.generateCalendar(year: year, month: month, counterID: counterID)
        
        // 検証
        XCTAssertTrue(result[day - 1].isCountedDay)
        XCTAssertFalse(result[day - 2 == 0 ? day + 1 : day - 2].isCountedDay)
    }
}
