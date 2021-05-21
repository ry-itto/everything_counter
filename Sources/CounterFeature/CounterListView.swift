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
                ForEach(viewStore.counters) { counter in
                    HStack {
                        Text(counter.title)
                            .font(.system(size: 18))
                        Spacer()
                        Button(
                            action: {},
                            label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .padding(.all, 8)
                                    .frame(width: 24, height: 24)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                            }
                        )
                        .scaledToFit()
                        Spacer()
                        Text("\(counter.value)")
                            .font(.system(size: 18))
                        Spacer()
                        Button(
                            action: {},
                            label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .padding(.all, 8)
                                    .frame(width: 24, height: 24)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                            }
                        )
                    }
                    .padding(.horizontal, 24)
                    Divider()
                }
            }.onAppear {
                viewStore.send(.refresh)
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
