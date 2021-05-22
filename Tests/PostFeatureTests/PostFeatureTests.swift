import ComposableArchitecture
import XCTest

@testable import PostFeature

final class PostFeatureTests: XCTestCase {
    func testChangeTitle() {
        let store = TestStore(
            initialState: .init(
                title: ""
            ),
            reducer: postReducer,
            environment: .init()
        )

        store.send(.binding(.set(\.title, "title1")), { state in
            state.title = "title1"
        })
    }
}
