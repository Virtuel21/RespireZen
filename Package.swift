// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "RespireZen",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .app(name: "RespireZen", targets: ["RespireZen"])
    ],
    targets: [
        .executableTarget(
            name: "RespireZen",
            path: "Sources/RespireZen",
            resources: [
                .copy("../../Resources")
            ]
        )
    ]
)
