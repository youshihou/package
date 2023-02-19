// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AttributedStringBuilder",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries, a package produces, and make them visible to other packages.
        .library(
            name: "AttributedStringBuilder",
            targets: ["AttributedStringBuilder"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/chriseidhof/SwiftHighlighting", branch: "main"),
        .package(url: "https://github.com/apple/swift-markdown", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AttributedStringBuilder",
            dependencies: [
                .product(name: "SwiftHighlighting", package: "SwiftHighlighting"),
                .product(name: "Markdown", package: "swift-markdown"),
            ]),
        .testTarget(
            name: "AttributedStringBuilderTests",
            dependencies: ["AttributedStringBuilder"]),
    ]
)
