import ComposableArchitecture
import SwiftUI

public struct CounterListView: View {
    let store: Store<CounterListState, CounterListAction>

    public init(store: Store<CounterListState, CounterListAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            LazyVStack {
                ForEachStore(
                    store.scope(
                        state: \.counters,
                        action: CounterListAction.cell(id:action:)
                    )
                ) { counterListCellStore in
                    CounterListCellView(store: counterListCellStore)
                    Divider()
                }
            }.onAppear {
                viewStore.send(.refresh)
            }
        }
    }
}
