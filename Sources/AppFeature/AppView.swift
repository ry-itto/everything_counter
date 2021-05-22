import ComposableArchitecture
import CounterFeature
import SwiftUI

public struct AppView: View {
    let store: Store<AppState, AppAction>

    public init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { _ in
            CounterListView(
                store: store.scope(
                    state: \.counterListState,
                    action: AppAction.counterList
                )
            )
        }
    }
}

public struct AppView_Previews: PreviewProvider {
    public static var previews: some View {
        AppView(
            store: .init(
                initialState: .init(),
                reducer: appReducer,
                environment: .init()
            )
        )
    }
}
