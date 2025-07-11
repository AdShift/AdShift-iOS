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
            url: "https://github.com/AdShift/AdShift-iOS/releases/download/1.0.3/AdshiftIOS.xcframework.zip",
            checksum: "6025acfe4a239f40605240247a52216740b36d4858f68c9509c6ac70f2286850"
        )
    ]
)
