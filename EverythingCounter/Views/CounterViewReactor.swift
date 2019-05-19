//
//  CounterViewReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RxSwift
import ReactorKit

final class CounterViewReactor: Reactor {
    
    private let service: CounterServiceProtocol
    
    var initialState: CounterViewReactor.State
    
    enum Action {
        case addCounter(title: String)
        case deleteCounter(title: String)
    }
    
    enum Mutation {
        case reloadData
    }
    
    struct State {
        var counters: [Counter]
    }
    
    init(_ service: CounterServiceProtocol = CounterService()) {
        self.initialState = State(counters: service.findAll())
        self.service = service
    }
    
    func mutate(action: CounterViewReactor.Action) -> Observable<CounterViewReactor.Mutation> {
        switch action {
        case .addCounter(let title):
            service.addCounter(title: title)
            return .just(.reloadData)
        case .deleteCounter(let title):
            return .just(.reloadData)
        }
    }
    
    func reduce(state: CounterViewReactor.State, mutation: CounterViewReactor.Mutation) -> CounterViewReactor.State {
        var state = state
        switch mutation {
        case .reloadData:
            state.counters = service.findAll()
            return state
        }
    }
}
