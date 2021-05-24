import Foundation
import RealmSwift

public final class Counter: Object {
    @objc public dynamic var id: String
    @objc public dynamic var title: String
    @objc public dynamic var value: Int

    public init(
        id: String = UUID().uuidString,
        title: String = "",
        value: Int = 0
    ) {
        self.id = id
        self.title = title
        self.value = value
    }

    override public static func primaryKey() -> String? {
        return "id"
    }
}
