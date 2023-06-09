// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "BeachDay",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "BeachDay",
            targets: ["AppModule"],
            bundleIdentifier: "thiagohba.com.BeachDay",
            teamIdentifier: "685GVH2XJC",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bunny),
            accentColor: .presetColor(.green),
            supportedDeviceFamilies: [
                .pad
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft,
                .portrait
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resource")
            ]
        )
    ]
)
