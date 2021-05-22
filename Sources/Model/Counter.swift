public struct Counter: Equatable, Identifiable {
    public var id: String
    public var title: String
    public var value: Int

    public init(id: String, title: String, value: Int) {
        self.id = id
        self.title = title
        self.value = value
    }
}
