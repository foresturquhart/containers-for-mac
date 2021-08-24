// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "hvs",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .executable(name: "hvs", targets: ["hvs"]),
    ],
    dependencies: [],
    targets: [
        .executableTarget(name: "hvs", dependencies: [], path: ".", exclude: ["hvs.entitlements", "Makefile"]),
    ]
)
