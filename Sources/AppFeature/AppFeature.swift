import ComposableArchitecture
import CounterFeature
import PostFeature
import Repository

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

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    counterListReducer.pullback(
        state: \.counterListState,
        action: /AppAction.counterList,
        environment: { environment in
            .init(
                counterRepository: environment.counterRepository,
                mainQueue: environment.mainQueue
            )
        }
    ),
    postReducer.optional().pullback(
        state: \.postState,
        action: /AppAction.post,
        environment: { environment in
            .init(
                counterRepository: environment.counterRepository,
                mainQueue: environment.mainQueue
            )
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
