//
//  CreateCounterViewReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import RxSwift
import ReactorKit

final class CreateCounterViewReactor: Reactor {

    private let service: CounterServiceProtocol

    var initialState: CreateCounterViewReactor.State

    enum Action {
        case create(counterName: String)
    }

    enum Mutation {
        case closeModal
    }

    struct State {
        var counterName: String
        var isCreated: Bool
    }

    init(_ service: CounterServiceProtocol = CounterService()) {
        self.initialState = State(counterName: "", isCreated: false)
        self.service = service
    }

    func mutate(action: CreateCounterViewReactor.Action) -> Observable<CreateCounterViewReactor.Mutation> {
        switch action {
        case .create(let counterName):
            service.addCounter(title: counterName)
            return .just(.closeModal)
        }
    }

    func reduce(state: CreateCounterViewReactor.State,
                mutation: CreateCounterViewReactor.Mutation) -> CreateCounterViewReactor.State {
        var state = state
        switch mutation {
        case .closeModal:
            state.isCreated = true
            return state
        }
    }
}
