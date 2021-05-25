import Combine
import Model
import RealmDB
import RealmModel

public protocol CounterRepository {
    func findAll() -> Future<[Model.Counter], Never>
    func create(title: String) -> Future<Model.Counter, Error>
    func update(counter: Model.Counter, title: String?, value: Int?) -> Future<Model.Counter, Error>
    func delete(counter: Model.Counter) -> Future<Model.Counter, Error>
}

public struct CounterRepositoryImpl: CounterRepository {
    public init() {}

    public func findAll() -> Future<[Model.Counter], Never> {
        .init { promise in
            promise(.success(RealmDB.shared.objects().map(Model.Counter.init(realm:))))
        }
    }

    public func create(title: String) -> Future<Model.Counter, Error> {
        let counter = RealmModel.Counter(title: title)
        let result = RealmDB.shared.add(model: counter).map(Model.Counter.init(realm:))
        return .init { promise in
            switch result {
            case let .success(counter):
                promise(.success(counter))
            case let .failure(e):
                promise(.failure(e))
            }
        }
    }

    public func update(counter: Model.Counter, title: String?, value: Int?) -> Future<Model.Counter, Error> {
        let result = RealmDB.shared.update(model: RealmModel.Counter(model: counter)) { realmModel in
            if let title = title {
                realmModel.title = title
            }
            if let value = value {
                realmModel.value = value
            }
        }.map(Model.Counter.init(realm:))
        return .init { promise in
            switch result {
            case let .success(counter):
                promise(.success(counter))
            case let .failure(e):
                promise(.failure(e))
            }
        }
    }

    public func delete(counter: Model.Counter) -> Future<Model.Counter, Error> {
        let result = RealmDB.shared.delete(model: RealmModel.Counter(model: counter))
            .map(Model.Counter.init(realm:))
        return .init { promise in
            switch result {
            case let .success(counter):
                promise(.success(counter))
            case let .failure(e):
                promise(.failure(e))
            }
        }
    }
}
