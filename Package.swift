// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWindowLauncher",
    platforms: [.macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WindowLauncher",
            targets: ["WindowLauncher"]),
        .executable(
            name: "CLI-Example",
            targets: ["CLIExample"]
        ),
        .executable(
            name: "MainFunc-Example",
            targets: ["MainFuncExample"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.3.0"),
    ],
    targets: [
        .target(
            name: "WindowLauncher"
        ),
        .executableTarget(
            name: "CLIExample",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "WindowLauncher"
            ]
        ),
        .executableTarget(
            name: "MainFuncExample",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "WindowLauncher"
            ]
        )
    ]
)
