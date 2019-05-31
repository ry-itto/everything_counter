//
//  CalendarReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RxSwift
import ReactorKit

final class CalendarReactor: Reactor {
    private let service: CalendarServiceProtocol
    var initialState: CalendarReactor.State
    
    enum Action {
        case changeMonth(month: Int)
    }
    
    enum Mutation {
        case updateCalendar(currentMonth: Int, days: [Day])
    }
    
    struct State {
        let counterID: String
        var currentYear: Int
        var currentMonth: Int
        var days: [Day]
    }
    
    init(_ service: CalendarServiceProtocol = CalendarService(),
         counterID: String) {
        let today = Date()
        initialState = State(
            counterID: counterID,
            currentYear: Calendar.current.component(.year, from: Date()),
            currentMonth: Calendar.current.component(.month, from: Date()),
            days: service.generateCalendar(
                year: Calendar.current.component(.year, from: today),
                month: Calendar.current.component(.month, from: today),
                counterID: counterID))
        self.service = service
    }
    
    func mutate(action: CalendarReactor.Action) -> Observable<CalendarReactor.Mutation> {
        switch action {
        case .changeMonth(let month):
            return .just(.updateCalendar(currentMonth: month, days: []))
        }
    }
    
    func reduce(state: CalendarReactor.State, mutation: CalendarReactor.Mutation) -> CalendarReactor.State {
        var state = state
        switch mutation {
        case .updateCalendar(let month, let days):
            state.currentMonth = month
            state.days = days
        }
        return state
    }
}
