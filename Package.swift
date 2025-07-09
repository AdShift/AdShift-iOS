// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdShiftIOS",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "AdShiftSDK",
            targets: ["AdShiftSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "AdShiftSDK",
            url: "https://github.com/AdShift/AdShift-iOS/releases/download/1.0.0/AdshiftIOS.xcframework.zip",
            checksum: "1a1d9a8ba507252890cdca0ff963c6085e959a917457a25f3be8b38953bf5c26"
        )
    ]
)
