//
//  CalendarExtension.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/28.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

extension Calendar {
    func weekDaySymbolsJa() -> [String] {
        return ["日", "月", "火", "水", "木", "金", "土"]
    }
    
    /// 月初めの曜日を返すメソッド
    ///
    /// - Parameter date: 対象月の日
    /// - Returns: 月初めの曜日
    func firstWeekDayOfMonth(for date: Date) -> Int {
        var component = self.dateComponents(in: .current, from: date)
        component.day = 1
        return component.weekday!
    }
}
