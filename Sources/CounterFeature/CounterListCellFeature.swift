import ComposableArchitecture
import Model
import Repository

public struct CounterListCellState: Equatable, Identifiable {
    public var counter: Counter

    public var id: String {
        counter.id
    }

    public init(counter: Counter) {
        self.counter = counter
    }
}

public enum CounterListCellAction: Equatable {
    case countUp
    case countDown
    case countResponse(Result<Counter, DBError>)
}

public struct CounterListCellEnvironment {
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

public let counterListCellReducer = Reducer<CounterListCellState, CounterListCellAction, CounterListCellEnvironment> { state, action, environment in
    switch action {
    case .countUp:
        return environment.counterRepository.update(
            counter: state.counter,
            title: nil,
            value: state.counter.value + 1
        )
        .receive(on: environment.mainQueue)
        .catchToEffect()
        .map(CounterListCellAction.countResponse)
    case .countDown:
        return environment.counterRepository.update(
            counter: state.counter,
            title: nil,
            value: state.counter.value - 1
        )
        .receive(on: environment.mainQueue)
        .catchToEffect()
        .map(CounterListCellAction.countResponse)
    case let .countResponse(.success(counter)):
        state.counter = counter
        return .none
    case .countResponse(.failure):
        return .none
    }
}
