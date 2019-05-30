//
//  CalendarService.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

struct Day {
    let dayOfWeek: Int
    let dayOfWeekStr: String
    let day: Int
}

protocol CalendarServiceProtocol {
    /// 与えられた年月のカレンダーを生成
    ///
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    /// - Returns: カレンダー
    func generateCalendar(year: Int, month: Int) -> [Day]
}

final class CalendarService: CalendarServiceProtocol {
    func generateCalendar(year: Int, month: Int) -> [Day] {
        var calendar = Calendar.current
        let dayOfWeekSymbols = calendar.weekDaySymbolsJa()
        
        guard let days = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: year, month: month))!) else { return [] }
        let firstWeekDay = calendar.firstWeekDayOfMonth(for: Date()) - 1
        var weekDay = firstWeekDay
        return days.map { day -> Day in
            defer {
                weekDay += 1
            }
            return Day(dayOfWeek: (weekDay - 1) % 7, dayOfWeekStr: dayOfWeekSymbols[(weekDay - 1) % 7], day: day)
        }
    }
}
