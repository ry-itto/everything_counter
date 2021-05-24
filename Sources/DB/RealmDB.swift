import RealmSwift

public struct RealmDB {
    public static let shared: Self = RealmDB()

    private let realm: Realm

    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError()
        }
    }

    func objects<T: Object>(
        where condition: (T) -> Bool = { _ in true }
    ) -> [T] {
        Array(realm.objects(T.self).filter(condition))
    }

    func add<T: Object>(model: T) -> Result<T, Error> {
        do {
            try realm.write {
                realm.add(model)
            }
        } catch let e {
            return .failure(e)
        }
        return .success(model)
    }

    func update<T: Object>(model: T, update: (inout T) -> Void) -> Result<T, Error> {
        var model = model
        do {
            try realm.write {
                update(&model)
            }
        } catch let e {
            return .failure(e)
        }
        return .success(model)
    }

    func delete<T: Object>(model: T) -> Result<T, Error> {
        do {
            try realm.write {
                realm.delete(model)
            }
        } catch let e {
            return .failure(e)
        }
        return .success(model)
    }

    func deleteAll<T: Object>(
        _ modelType: T.Type,
        where condition: (T) -> Bool = { _ in true }
    ) -> Result<Void, Error> {
        let objects = realm.objects(modelType).filter(condition)
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch let e {
            return .failure(e)
        }
        return .success(())
    }
}
