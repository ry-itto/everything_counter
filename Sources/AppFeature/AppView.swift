import ComposableArchitecture
import CounterFeature
import PostFeature
import SwiftUI

public struct AppView: View {
    let store: Store<AppState, AppAction>

    public init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                CounterListView(
                    store: store.scope(
                        state: \.counterListState,
                        action: AppAction.counterList
                    )
                )
                Button {
                    viewStore.send(.presentPost)
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(.all, 8)
                        .frame(width: 48, height: 48)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isPresentedPost,
                    send: .dismissPost
                )
            ) {
                IfLetStore(
                    store.scope(
                        state: \.postState,
                        action: AppAction.post
                    )
                ) { postStore in
                    PostView(store: postStore)
                }
            }
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
