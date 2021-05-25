import ComposableArchitecture
import Model
import Repository

public struct CounterListState: Equatable {
    public var counters: IdentifiedArrayOf<CounterListCellState>

    public init(counters: IdentifiedArrayOf<CounterListCellState> = .init()) {
        self.counters = counters
    }
}

public enum CounterListAction: Equatable {
    case refresh
    case refreshResponse(Result<[Counter], Never>)
    case cell(id: String, action: CounterListCellAction)
}

public struct CounterListEnvironment {
    public let counterRepository: CounterRepository
    public let mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        counterRepository: CounterRepository,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.counterRepository = counterRepository
        self.mainQueue = mainQueue
    }
}

public let counterListReducer = Reducer<CounterListState, CounterListAction, CounterListEnvironment>.combine(
    counterListCellReducer.forEach(
        state: \.counters,
        action: /CounterListAction.cell(id:action:),
        environment: { environment in
            .init(
                counterRepository: environment.counterRepository,
                mainQueue: environment.mainQueue
            )
        }
    ),
    .init { state, action, environment in
        switch action {
        case .refresh:
            return environment.counterRepository.findAll()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(CounterListAction.refreshResponse)
                .eraseToEffect()
        case let .refreshResponse(.success(counters)):
            state.counters = IdentifiedArray(
                counters.map(CounterListCellState.init(counter:))
            )
            return .none
        case .cell:
            return .none
        }
    }
)
