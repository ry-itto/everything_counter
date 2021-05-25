import Foundation

public enum DBError: Error, Equatable {
    case unknown(Error)

    public static func == (lhs: DBError, rhs: DBError) -> Bool {
        switch (lhs, rhs) {
        case let (.unknown(lError), .unknown(rError)):
            return lError.localizedDescription == rError.localizedDescription
        }
    }
}
