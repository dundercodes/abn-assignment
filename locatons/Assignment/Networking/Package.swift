// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "Networking",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Networking",
      type: .dynamic,
      targets: ["Networking"]
    )
  ],
  targets: [
    .target(
      name: "Networking",
      path: "Sources"
    )
  ]
)
