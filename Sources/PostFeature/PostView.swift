import ComposableArchitecture
import SwiftUI

public struct PostView: View {
    @Environment(\.presentationMode) var presentationMode
    let store: Store<PostState, PostAction>

    public init(store: Store<PostState, PostAction>) {
        self.store = store
    }

    public var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                Form {
                    Section(header: Text("カウンター情報")) {
                        TextField(
                            "新しいカウンター名",
                            text: viewStore.binding(
                                keyPath: \.title,
                                send: PostAction.binding
                            )
                        )
                    }
                }
                .navigationTitle("新規カウンター作成")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("登録") {
                    viewStore.send(.post)
                })
            }
        }
    }
}
