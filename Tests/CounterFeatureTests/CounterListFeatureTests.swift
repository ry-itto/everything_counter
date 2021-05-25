import ComposableArchitecture
import Mock
import Model
import XCTest

@testable import CounterFeature

final class CounterListFeatureTests: XCTestCase {
    func testRefresh() {
        let result: [Counter] = [
            .init(id: "1", title: "Task 1", value: 0),
            .init(id: "2", title: "Task 2", value: 1),
            .init(id: "3", title: "Task 3", value: 2),
        ]
        let store = TestStore(
            initialState: .init(),
            reducer: counterListReducer,
            environment: .init(
                counterRepository: CounterRepositoryMock(
                    findAll: .success(result)
                ),
                mainQueue: .immediate
            )
        )

        store.send(.refresh)
        store.receive(.refreshResponse(.success(result))) { state in
            state.counters = IdentifiedArray(result.map(CounterListCellState.init(counter:)))
        }
    }
}
