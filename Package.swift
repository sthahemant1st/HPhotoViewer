// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HPhotoViewer",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "HPhotoViewer",
            targets: ["HPhotoViewer"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HPhotoViewer",
            path: "HPhotoViewer"),
    ]
)
