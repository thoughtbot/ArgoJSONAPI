// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "ArgoJSONAPI",
  products: [
    .library(name: "ArgoJSONAPI", targets: ["ArgoJSONAPI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/thoughtbot/Argo.git", from: "4.0.0"),
    .package(url: "https://github.com/Quick/Quick.git", .branch("as-swift-4-swift-3-compat")),
    .package(url: "https://github.com/Quick/Nimble.git", .branch("as-swift-4-swift-3-compat")),
  ],
  targets: [
    .target(
      name: "ArgoJSONAPI",
      dependencies: [
        "Argo",
      ]
    ),
    .testTarget(
      name: "TestResources",
      dependencies: [
        "ArgoJSONAPI",
      ]
    ),
    .testTarget(
      name: "ArgoJSONAPITests",
      dependencies: [
        "ArgoJSONAPI",
        "TestResources",
        "Quick",
        "Nimble",
      ]
    ),
  ],
  swiftLanguageVersions: [3, 4]
)
