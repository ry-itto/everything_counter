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
    var initialState: CounterViewReactor.State
    
    enum Action {
        case addCounter(title: String)
        case deleteCounter(title: String)
    }
    
    enum Mutation {
        case addCounter(title: String)
        case deleteCounter(title: String)
    }
    
    struct State {
        var counterNames: [String]
    }
    
    init() {
        self.initialState = State(counterNames: ["心理学欠席回数", "寝た回数", "お金もらった回数"])
    }
    
    func mutate(action: CounterViewReactor.Action) -> Observable<CounterViewReactor.Mutation> {
        switch action {
        case .addCounter(let title):
            return .just(.addCounter(title: title))
        case .deleteCounter(let title):
            return .just(.deleteCounter(title: title))
        }
    }
    
    func reduce(state: CounterViewReactor.State, mutation: CounterViewReactor.Mutation) -> CounterViewReactor.State {
        var state = state
        switch mutation {
        case .addCounter(let title):
            state.counterNames.append(title)
            return state
        case .deleteCounter(let title):
            guard let index = state.counterNames.firstIndex(of: title) else { return state }
            state.counterNames.remove(at: index)
            return state
        }
    }
}
