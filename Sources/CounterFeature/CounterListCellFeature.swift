import ComposableArchitecture
import Model

public struct CounterListCellState: Equatable, Identifiable {
    public var counter: Counter

    public var id: String {
        counter.id
    }

    public init(counter: Counter) {
        self.counter = counter
    }
}

public enum CounterListCellAction {
    case countUp
    case countDown
}

public struct CounterListCellEnvironment {
    public init() {}
}

public let counterListCellReducer = Reducer<CounterListCellState, CounterListCellAction, CounterListCellEnvironment> { state, action, _ in
    switch action {
    case .countUp:
        state.counter.value += 1
        return .none
    case .countDown:
        state.counter.value -= 1
        return .none
    }
}
