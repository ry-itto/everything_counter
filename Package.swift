// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppPackage",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]
        ),
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.7.6"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.18.0"),
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                .target(name: "CounterFeature"),
                .target(name: "PostFeature"),
                .target(name: "Repository"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CounterFeature",
            dependencies: [
                .target(name: "Model"),
                .target(name: "Repository"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "Mock",
            dependencies: [
                .target(name: "Model"),
                .target(name: "Repository"),
            ]
        ),
        .target(name: "Model"),
        .target(
            name: "PostFeature",
            dependencies: [
                .target(name: "Model"),
                .target(name: "Repository"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "RealmDB",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
            ]
        ),
        .target(
            name: "RealmModel",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
            ]
        ),
        .target(
            name: "Repository",
            dependencies: [
                .target(name: "Model"),
                .target(name: "RealmDB"),
                .target(name: "RealmModel")
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: [
                "AppFeature",
                "Mock",
            ]
        ),
        .testTarget(
            name: "CounterFeatureTests",
            dependencies: [
                "CounterFeature",
                "Mock",
            ]
        ),
        .testTarget(
            name: "PostFeatureTests",
            dependencies: [
                "PostFeature",
                "Mock",
            ]
        ),
    ]
)
