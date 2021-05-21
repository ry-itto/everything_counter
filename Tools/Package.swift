// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Tools",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", .exact("0.43.1")),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", .exact("0.47.13")),
    ],
    targets: [
    ]
)
