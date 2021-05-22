import ComposableArchitecture
import CounterFeature
import PostFeature

public struct AppState: Equatable {
    public var counterListState: CounterListState
    public var postState: PostState?

    public var isPresentedPost: Bool {
        postState != nil
    }

    public init(
        counterListState: CounterListState = .init(),
        postState: PostState? = nil
    ) {
        self.counterListState = counterListState
        self.postState = postState
    }
}

public enum AppAction {
    case presentPost
    case dismissPost

    case counterList(CounterListAction)
    case post(PostAction)
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
    postReducer.optional().pullback(
        state: \.postState,
        action: /AppAction.post,
        environment: { _ in
            .init()
        }
    ),
    .init { state, action, _ in
        switch action {
        case .presentPost:
            state.postState = .init()
            return .none
        case .dismissPost:
            state.postState = nil
            return .none
        case .counterList:
            return .none
        case .post:
            return .none
        }
    }
)
