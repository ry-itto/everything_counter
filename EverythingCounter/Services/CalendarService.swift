//
//  CalendarService.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

struct Day {
    let month: Int
    let dayOfWeek: Int
    let dayOfWeekStr: String
    let day: Int
    let isCountedDay: Bool

    /// Dayが今日のものかどうか判定する
    ///
    /// - Returns: 真偽値
    func isToday() -> Bool {
        let month = Calendar.current.component(.month, from: Date())
        if self.month != month {
            return false
        }
        let today = Calendar.current.component(.day, from: Date())

        return today == day
    }
}

protocol CalendarServiceProtocol {
    /// 与えられた年月のカレンダーを生成
    ///
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    /// - Returns: カレンダー
    func generateCalendar(year: Int, month: Int, counterID: String) -> [Day]
}

final class CalendarService: CalendarServiceProtocol {

    private let store: CountStoreProtocol

    init(_ store: CountStoreProtocol = CountStore.shared) {
        self.store = store
    }

    func generateCalendar(year: Int, month: Int, counterID: String) -> [Day] {
        var calendar = Calendar.current
        let dayOfWeekSymbols = calendar.weekDaySymbolsJa()
        /// 対象月を取得
        let targetDate = calendar.date(from: DateComponents(year: year, month: month))!

        /// 月の日数を取得
        guard let days = calendar.range(of: .day, in: .month, for: targetDate) else { return [] }

        let firstWeekDay = calendar.firstWeekDayOfMonth(for: targetDate) - 1
        var weekDay = firstWeekDay
        /// カウントされた日付を取得.
        let countDays = findAllCounts(counterID: counterID)
            .map { $0.countDate }
            .filter { calendar.component(.month, from: $0) == month }
            .map { calendar.component(.day, from: $0) }

        return days.map { day -> Day in
            defer {
                weekDay += 1
            }
            return Day(month: month,
                       dayOfWeek: weekDay % 7,
                       dayOfWeekStr: dayOfWeekSymbols[weekDay % 7],
                       day: day,
                       isCountedDay: countDays.contains(day))
        }
    }

    /// 全てのカウントした日を取得
    ///
    /// - Parameter counterID: カウンターID
    /// - Returns: カウントした日全て
    private func findAllCounts(counterID: String) -> [Count] {
        return Array(store.findByCounterID(counterID: counterID))
    }
}
