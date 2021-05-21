import ComposableArchitecture
import CounterFeature

public struct AppState: Equatable {
    public var counterListState: CounterListState

    public init(
        counterListState: CounterListState = .init()
    ) {
        self.counterListState = counterListState
    }
}

public enum AppAction {
    case counterList(CounterListAction)
}

public struct AppEnvironment {
    public init() {}
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    counterListReducer.pullback(
        state: \.counterListState,
        action: /AppAction.counterList,
        environment: { _ in
            .init()
        }
    ),
    .init { _, action, _ in
        switch action {
        case .counterList:
            return .none
        }
    }
)
