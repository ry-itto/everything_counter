import ComposableArchitecture
import SwiftUI

public struct PostView: View {
    let store: Store<PostState, PostAction>

    public init(store: Store<PostState, PostAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewStore.send(.post)
                    } label: {
                        Text("登録")
                    }
                }
                TextField(
                    "新しいカウンター名",
                    text: viewStore.binding(
                        keyPath: \.title,
                        send: PostAction.binding
                    )
                )
            }
        }
    }
}

public struct SwiftUIView_Previews: PreviewProvider {
    public static var previews: some View {
        PostView()
    }
}
