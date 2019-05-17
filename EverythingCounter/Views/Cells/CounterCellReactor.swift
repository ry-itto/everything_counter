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
    let initialState: CounterCellReactor.State
    
    /// Viewが起こすアクション
    enum Action {
        case increase
        case decrease
    }
    
    /// アクションによる変更内容
    enum Mutation {
        case increaseValue
        case decreaseValue
    }
    
    /// Viewの状態
    struct State {
        var value: Int
    }
    
    init() {
        self.initialState = State(value: 0)
    }
    
    /// アクションを受け取ってMutationを生成する
    func mutate(action: CounterCellReactor.Action) -> Observable<CounterCellReactor.Mutation> {
        switch action {
        case .increase:
            print("increase")
            return .just(.increaseValue)
        case .decrease:
            return .just(.decreaseValue)
        }
    }
    
    /// Mutationを受け取ってStateを更新する
    func reduce(state: CounterCellReactor.State, mutation: CounterCellReactor.Mutation) -> CounterCellReactor.State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
            return state
        case .decreaseValue:
            state.value -= 1
            return state
        }
    }
}
