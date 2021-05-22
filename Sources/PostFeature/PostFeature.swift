import ComposableArchitecture
import Model

public struct PostState: Equatable {
    public var title: String

    public init(title: String = "") {
        self.title = title
    }
}

public enum PostAction: Equatable {
    case post
    case binding(BindingAction<PostState>)
}

public struct PostEnvironment {
    public init() {}
}

public let postReducer = Reducer<PostState, PostAction, PostEnvironment> { _, action, _ in
    switch action {
    case .post:
        return .none
    case .binding:
        return .none
    }
}
.binding(action: /PostAction.binding)
