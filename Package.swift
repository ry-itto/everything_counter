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
        .target(name: "Model"),
        .target(
            name: "PostFeature",
            dependencies: [
                .target(name: "Model"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
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
