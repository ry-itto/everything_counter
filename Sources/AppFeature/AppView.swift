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
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    CounterListView(
                        store: store.scope(
                            state: \.counterListState,
                            action: AppAction.counterList
                        )
                    )
                    .frame(maxHeight: .infinity)
                    Button {
                        viewStore.send(.presentPost)
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(.all, 12)
                            .frame(width: 48, height: 48)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .offset(x: -12, y: -12)
                }
                .navigationTitle("カウンター一覧")
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
}
