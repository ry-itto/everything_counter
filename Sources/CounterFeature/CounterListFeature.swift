import ComposableArchitecture
import Model

public struct CounterListState: Equatable {
    public var counters: IdentifiedArrayOf<CounterListCellState>

    public init(counters: IdentifiedArrayOf<CounterListCellState> = .init()) {
        self.counters = counters
    }
}

public enum CounterListAction {
    case refresh
    case cell(id: String, action: CounterListCellAction)
}

public struct CounterListEnvironment {
    public init() {}
}

public let counterListReducer = Reducer<CounterListState, CounterListAction, CounterListEnvironment>.combine(
    counterListCellReducer.forEach(
        state: \.counters,
        action: /CounterListAction.cell(id:action:),
        environment: { _ in
            .init()
        }
    ),
    .init { state, action, environment in
        switch action {
        case .refresh:
            state.counters = IdentifiedArray(
                [
                    Counter(id: "1", title: "Task 1", value: 0),
                    Counter(id: "2", title: "Task 2", value: 1),
                    Counter(id: "3", title: "Task 3", value: 2),
                ]
                .map(CounterListCellState.init(counter:))
            )
            return .none
        case .cell:
            return .none
        }
    }
)
