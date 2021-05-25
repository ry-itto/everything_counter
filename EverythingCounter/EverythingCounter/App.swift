import AppFeature
import SwiftUI

@main
struct EverythingCounterApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(
                    initialState: .init(),
                    reducer: appReducer,
                    environment: .main
                )
            )
        }
    }
}
