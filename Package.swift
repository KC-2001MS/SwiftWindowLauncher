// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWindowLauncher",
    platforms: [.macOS(.v27)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WindowLauncher",
            targets: ["WindowLauncher"]),
        .executable(
            name: "CLI-SwiftUI-Example",
            targets: ["CLISwiftUIExample"]
        ),
        .executable(
            name: "CLI-AppKit-Example",
            targets: ["CLIAppKitExample"]
        ),
        .executable(
            name: "MainFunc-SwiftUI-Example",
            targets: ["MainFuncSwiftUIExample"]
        ),
        .executable(
            name: "MainFunc-AppKit-Example",
            targets: ["MainFuncAppKitExample"]
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
            name: "CLISwiftUIExample",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "WindowLauncher"
            ]
        ),
        .executableTarget(
            name: "CLIAppKitExample",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "WindowLauncher"
            ]
        ),
        .executableTarget(
            name: "MainFuncSwiftUIExample",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "WindowLauncher"
            ]
        ),
        .executableTarget(
            name: "MainFuncAppKitExample",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "WindowLauncher"
            ]
        )
    ]
)
