import ComposableArchitecture
import SwiftUI

public struct AppView: View {
    let store: Store<AppState, AppAction>

    public init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { _ in
            Text("Hello, World!")
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
