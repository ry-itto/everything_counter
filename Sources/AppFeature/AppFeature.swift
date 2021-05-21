import ComposableArchitecture

public struct AppState: Equatable {
    public init() {}
}

public enum AppAction {
}

public struct AppEnvironment {
    public init() {}
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    .none
}
