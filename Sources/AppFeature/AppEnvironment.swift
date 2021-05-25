import Foundation
import Repository

public extension AppEnvironment {
    static var main: Self {
        .init(
            counterRepository: CounterRepositoryImpl(),
            mainQueue: .main
        )
    }
}
