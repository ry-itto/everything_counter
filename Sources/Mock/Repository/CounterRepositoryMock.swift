import Combine
import Model
import Repository

public struct CounterRepositoryMock: CounterRepository {
    private let _findAll: Result<[Counter], Never>?
    private let _create: Result<Counter, DBError>?
    private let _update: Result<Counter, DBError>?
    private let _delete: Result<Counter, DBError>?

    public init(
        findAll: Result<[Counter], Never>? = nil,
        create: Result<Counter, DBError>? = nil,
        update: Result<Counter, DBError>? = nil,
        delete: Result<Counter, DBError>? = nil
    ) {
        _findAll = findAll
        _create = create
        _update = update
        _delete = delete
    }

    public func findAll() -> Future<[Counter], Never> {
        .init {
            $0(_findAll!)
        }
    }

    public func create(title: String) -> Future<Counter, DBError> {
        .init {
            $0(_create!)
        }
    }

    public func update(counter: Counter, title: String?, value: Int?) -> Future<Counter, DBError> {
        .init {
            $0(_update!)
        }
    }

    public func delete(counter: Counter) -> Future<Counter, DBError> {
        .init {
            $0(_delete!)
        }
    }


}
