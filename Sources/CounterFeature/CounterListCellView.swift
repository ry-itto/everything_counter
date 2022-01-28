import ComposableArchitecture
import SwiftUI

public struct CounterListCellView: View {
    let store: Store<CounterListCellState, CounterListCellAction>

    public init(store: Store<CounterListCellState, CounterListCellAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Text(viewStore.counter.title)
                    .font(.system(size: 18))
                Spacer()
                CountButton(type: .down) {
                    viewStore.send(.countDown)
                }
                .scaledToFit()
                Spacer()
                Text("\(viewStore.counter.value)")
                    .font(.system(size: 18))
                Spacer()
                CountButton(type: .up) {
                    viewStore.send(.countUp)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}
