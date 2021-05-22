import ComposableArchitecture
import Model

public struct CounterListState: Equatable {
    public var counters: [Counter]

    public init(counters: [Counter] = []) {
        self.counters = counters
    }
}

public enum CounterListAction {
    case refresh
}

public struct CounterListEnvironment {
    public init() {}
}

public let counterListReducer = Reducer<CounterListState, CounterListAction, CounterListEnvironment> { state, action, environment in
    switch action {
    case .refresh:
        state.counters = [
            .init(id: "1", title: "Task 1", value: 0),
            .init(id: "2", title: "Task 2", value: 1),
            .init(id: "3", title: "Task 3", value: 2),
        ]
        return .none
    }
}
