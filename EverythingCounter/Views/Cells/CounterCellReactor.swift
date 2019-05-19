//
//  CounterCellReactor.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import ReactorKit
import RxSwift

final class CounterCellReactor: Reactor {
    private let service: CounterServiceProtocol
    private let counter: Counter
    
    let initialState: CounterCellReactor.State
    
    /// Viewが起こすアクション
    enum Action {
        case increase
        case decrease
    }
    
    /// アクションによる変更内容
    enum Mutation {
        case increaseValue(_ updated: Counter)
        case decreaseValue
    }
    
    /// Viewの状態
    struct State {
        var value: Int
    }
    
    init(_ service: CounterServiceProtocol = CounterService(), counter: Counter) {
        self.initialState = State(value: counter.value)
        self.service = service
        self.counter = counter
    }
    
    /// アクションを受け取ってMutationを生成する
    func mutate(action: CounterCellReactor.Action) -> Observable<CounterCellReactor.Mutation> {
        switch action {
        case .increase:
            let updated = service.update(counter, title: nil, value: counter.value + 1)
            return .just(.increaseValue(updated))
        case .decrease:
            return .just(.decreaseValue)
        }
    }
    
    /// Mutationを受け取ってStateを更新する
    func reduce(state: CounterCellReactor.State, mutation: CounterCellReactor.Mutation) -> CounterCellReactor.State {
        var state = state
        switch mutation {
        case .increaseValue(let updated):
            state.value = updated.value
            return state
        case .decreaseValue:
            state.value -= 1
            return state
        }
    }
}
