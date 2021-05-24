import Model
import RealmModel

internal extension Model.Counter {
    init(realm: RealmModel.Counter) {
        self.init(
            id: realm.id,
            title: realm.title,
            value: realm.value
        )
    }
}

internal extension RealmModel.Counter {
    convenience init(model: Model.Counter) {
        self.init(
            id: model.id,
            title: model.title,
            value: model.value
        )
    }
}
