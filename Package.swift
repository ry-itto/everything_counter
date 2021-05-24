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
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CounterFeature",
            dependencies: [
                .target(name: "Model"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "DB",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
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
            name: "Repository",
            dependencies: [
                .target(name: "DB"),
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),
        .testTarget(
            name: "CounterFeatureTests",
            dependencies: ["CounterFeature"]
        ),
        .testTarget(
            name: "PostFeatureTests",
            dependencies: ["PostFeature"]
        ),
    ]
)
