//
//  CalendarService.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

enum DayOfWeek: Int8 {
    case sunday
    case monday
    case tuesday
    case wendnesday
    case thursday
    case friday
    case saturday
    
    
    
    /// 曜日日本語文字列を取得
    ///
    /// - Returns: 曜日の日本語文字列
    func string() -> String {
        switch self {
        case .sunday:
            return "日"
        case .monday:
            return "月"
        case .tuesday:
            return "火"
        case .wendnesday:
            return "水"
        case .thursday:
            return "木"
        case .friday:
            return "金"
        case .saturday:
            return "土"
        }
    }
    
    /// 曜日の配列を返す
    ///
    /// - Parameter startWith: 始まる曜日
    /// - Returns: 曜日の配列
    func array(startWith: StartWith) -> [DayOfWeek] {
        switch startWith {
        case .monday:
            return [.monday, .tuesday, .wendnesday,
                    .thursday, .friday, .saturday, .sunday]
        case .sunday:
            return [.sunday, .monday, .tuesday, .wendnesday,
                .thursday, .friday, .saturday]
        }
    }
    
    enum StartWith {
        case monday
        case sunday
    }
}

struct CalendarInfo {
    let startDayOfWeek: DayOfWeek
    let endDay: Int8
}

protocol CalendarServiceProtocol {
    func generateCalendar(from month: Int8)
}

final class CalendarService: CalendarServiceProtocol {
    func generateCalendar(from month: Int8) {
        Calendar(identifier: .japanese).weekdaySymbols
    }
}
