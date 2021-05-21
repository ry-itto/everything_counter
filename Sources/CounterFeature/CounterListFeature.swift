import ComposableArchitecture

public struct CounterListState: Equatable {
    public var counters: [String]

    public init(counters: [String] = []) {
        self.counters = counters
    }
}

public enum CounterListAction {
}

public struct CounterListEnvironment {
    public init() {}
}

public let counterListReducer = Reducer<CounterListState, CounterListAction, CounterListEnvironment> { state, action, environment in
    .none
}
