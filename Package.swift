// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppPackage",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: []),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]),
    ]
)
