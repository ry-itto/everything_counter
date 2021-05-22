import ComposableArchitecture
import XCTest

@testable import CounterFeature

final class CounterListFeatureTests: XCTestCase {
    func testRefresh() {
        let store = TestStore(
            initialState: .init(),
            reducer: counterListReducer,
            environment: .init()
        )

        store.send(.refresh, { state in
            state.counters = IdentifiedArrayOf(
                [
                    .init(id: "1", title: "Task 1", value: 0),
                    .init(id: "2", title: "Task 2", value: 1),
                    .init(id: "3", title: "Task 3", value: 2),
                ]
                .map(CounterListCellState.init(counter:))
            )
        })
    }
}

