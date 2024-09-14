// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "CoreNetwork",
                 targets: ["CoreNetwork"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoreNetwork",
            dependencies: []),
    ]
)
