//
//  InputCounterInfoReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import ReactorKit
import RxSwift

final class InputCounterInfoReactor: Reactor {

    private let service: CounterServiceProtocol

    var initialState: InputCounterInfoReactor.State

    enum Action {
        case create(counterName: String)
        case edit(counter: Counter, counterName: String)
    }

    enum Mutation {
        case closeModal
    }

    struct State {
        var counterName: String
        var isEnded: Bool
    }

    init(_ service: CounterServiceProtocol = CounterService()) {
        self.initialState = State(counterName: "", isEnded: false)
        self.service = service
    }

    func mutate(action: InputCounterInfoReactor.Action) -> Observable<InputCounterInfoReactor.Mutation> {
        switch action {
        case .create(let counterName):
            service.addCounter(title: counterName)
            return .just(.closeModal)
        case .edit(let counter, let counterName):
            _ = service.update(counter, title: counterName, value: nil, type: nil)
            return .just(.closeModal)
        }
    }

    func reduce(state: InputCounterInfoReactor.State,
                mutation: InputCounterInfoReactor.Mutation) -> InputCounterInfoReactor.State {
        var state = state
        switch mutation {
        case .closeModal:
            state.isEnded = true
            return state
        }
    }
}
