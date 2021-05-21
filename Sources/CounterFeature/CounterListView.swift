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
                ForEach(viewStore.counters, id: \.self) { counter in
                    Text(counter)
                }
            }
        }
    }
}

public struct CounterListView_Previews: PreviewProvider {
    public static var previews: some View {
        CounterListView(
            store: .init(
                initialState: .init(
                    counters: []
                ),
                reducer: counterListReducer,
                environment: .init()
            )
        )
    }
}
