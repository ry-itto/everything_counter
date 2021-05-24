import Model
import RealmDB
import RealmModel

public protocol CounterRepository {
    func findAll() -> [Model.Counter]
    func create(title: String) -> Result<Model.Counter, Error>
    func update(counter: Model.Counter, title: String?, value: Int?) -> Result<Model.Counter, Error>
    func delete(counter: Model.Counter) -> Result<Model.Counter, Error>
}

public struct CounterRepositoryImpl: CounterRepository {
    public func findAll() -> [Model.Counter] {
        RealmDB.shared.objects().map(Model.Counter.init(realm:))
    }

    public func create(title: String) -> Result<Model.Counter, Error> {
        let counter = RealmModel.Counter(title: title)
        return RealmDB.shared.add(model: counter).map(Model.Counter.init(realm:))
    }

    public func update(counter: Model.Counter, title: String?, value: Int?) -> Result<Model.Counter, Error> {
        RealmDB.shared.update(model: RealmModel.Counter(model: counter)) { realmModel in
            if let title = title {
                realmModel.title = title
            }
            if let value = value {
                realmModel.value = value
            }
        }.map(Model.Counter.init(realm:))
    }

    public func delete(counter: Model.Counter) -> Result<Model.Counter, Error> {
        RealmDB.shared.delete(model: RealmModel.Counter(model: counter))
            .map(Model.Counter.init(realm:))
    }
}
