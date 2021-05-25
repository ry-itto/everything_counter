import ComposableArchitecture
import Model
import Repository

public struct PostState: Equatable {
    public var title: String

    public init(title: String = "") {
        self.title = title
    }
}

public enum PostAction: Equatable {
    case post
    case postResponse(Result<Counter, DBError>)
    case binding(BindingAction<PostState>)
}

public struct PostEnvironment {
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

public let postReducer = Reducer<PostState, PostAction, PostEnvironment> { state, action, environment in
    switch action {
    case .post:
        return environment.counterRepository.create(title: state.title)
            .catchToEffect()
            .receive(on: environment.mainQueue)
            .map(PostAction.postResponse)
            .eraseToEffect()
    case .postResponse(.success):
        return .none
    case .postResponse(.failure):
        return .none
    case .binding:
        return .none
    }
}
.binding(action: /PostAction.binding)
