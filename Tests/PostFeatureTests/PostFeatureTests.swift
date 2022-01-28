import ComposableArchitecture
import Mock
import Model
import XCTest

@testable import PostFeature

final class PostFeatureTests: XCTestCase {
    func testChangeTitle() {
        let store = TestStore(
            initialState: .init(
                title: ""
            ),
            reducer: postReducer,
            environment: .init(
                counterRepository: CounterRepositoryMock(),
                mainQueue: .immediate
            )
        )

        store.send(.binding(.set(\.title, "title1"))) { state in
            state.title = "title1"
        }
    }

    func testPost() {
        let result = Counter(id: "1", title: "Created Title", value: 0)
        let store = TestStore(
            initialState: .init(
                title: ""
            ),
            reducer: postReducer,
            environment: .init(
                counterRepository: CounterRepositoryMock(
                    create: .success(result)
                ),
                mainQueue: .immediate
            )
        )

        store.send(.post)
        store.receive(.postResponse(.success(result)))
    }
}
