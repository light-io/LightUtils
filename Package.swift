// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LightUtils",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "LightUtils",
            type: .static,
            targets: ["LightUtils"]
        ),
    ],
    targets: [
        .target(
            name: "LightUtils",
            dependencies: []),
        .testTarget(
            name: "LightUtilsTests",
            dependencies: ["LightUtils"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
