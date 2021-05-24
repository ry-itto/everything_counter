import ComposableArchitecture
import XCTest

@testable import CounterFeature

final class CounterListCellFeatureTests: XCTestCase {
    func testCount() {
        let store = TestStore(
            initialState: .init(
                counter: .init(
                    id: "1",
                    title: "Test",
                    value: 0
                )
            ),
            reducer: counterListCellReducer,
            environment: .init()
        )

        store.send(.countUp) { state in
            state.counter.value = 1
        }

        store.send(.countDown) { state in
            state.counter.value = 0
        }
    }
}
