//
//  CalendarReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RxSwift
import ReactorKit

enum CalendarChangeType {
    case next
    case previous
}

final class CalendarReactor: Reactor {
    private let service: CalendarServiceProtocol
    var initialState: CalendarReactor.State
    
    enum Action {
        case changeToPreviousMonth
        case changeToNextMonth
    }
    
    enum Mutation {
        case updateCalendar(type: CalendarChangeType)
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
        case .changeToPreviousMonth:
            return .just(.updateCalendar(type: .previous))
        case .changeToNextMonth:
            return .just(.updateCalendar(type: .next))
        }
    }
    
    func reduce(state: CalendarReactor.State, mutation: CalendarReactor.Mutation) -> CalendarReactor.State {
        var state = state
        switch mutation {
        case .updateCalendar(let type):
            switch type {
            case .next:
                state.currentMonth += 1
            case .previous:
                state.currentMonth -= 1
            }
            
            switch state.currentMonth{
            case 0:
                state.currentMonth = 12
                state.currentYear -= 1
            case 13:
                state.currentMonth = 1
                state.currentYear += 1
            default:
                break
            }
            state.days = service.generateCalendar(
                year: state.currentYear,
                month: state.currentMonth,
                counterID: state.counterID)
        }
        return state
    }
}
