import ComposableArchitecture
import Mock
import Model
import XCTest

@testable import CounterFeature

final class CounterListCellFeatureTests: XCTestCase {
    func testCountUp() {
        let result = Counter(
            id: "1",
            title: "Test",
            value: 1
        )
        let store = TestStore(
            initialState: .init(
                counter: .init(
                    id: "1",
                    title: "Test",
                    value: 0
                )
            ),
            reducer: counterListCellReducer,
            environment: .init(
                counterRepository: CounterRepositoryMock(
                    update: .success(result)
                ),
                mainQueue: .immediate
            )
        )

        store.send(.countUp)
        store.receive(.countResponse(.success(result))) { state in
            state.counter = result
        }
    }

    func testCountDown() {
        let result = Counter(
            id: "1",
            title: "Test",
            value: -1
        )
        let store = TestStore(
            initialState: .init(
                counter: .init(
                    id: "1",
                    title: "Test",
                    value: 0
                )
            ),
            reducer: counterListCellReducer,
            environment: .init(
                counterRepository: CounterRepositoryMock(
                    update: .success(result)
                ),
                mainQueue: .immediate
            )
        )

        store.send(.countDown)
        store.receive(.countResponse(.success(result))) { state in
            state.counter = result
        }
    }
}
