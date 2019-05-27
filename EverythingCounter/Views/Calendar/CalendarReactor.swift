//
//  CalendarReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import ReactorKit

final class CalendarReactor: Reactor {
    var initialState: CalendarReactor.State
    
    enum Action {
        case changeMonth
    }
    
    struct State {
        let currentMonth: Int8
        let days: [Int8]
    }
    
    init() {
        initialState = State(currentMonth: 1, days: [1, 2, 3, 4])
    }
}
