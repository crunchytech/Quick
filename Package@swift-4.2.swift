// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Quick",
    products: [
        .library(name: "Quick", targets: ["Quick"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"),
    ],
    targets: {
        var targets: [Target] = [
            .target(name: "QuickTestHelpers", dependencies: []),
            .testTarget(
                name: "QuickTests",
                dependencies: [ "Quick", "QuickTestHelpers", "Nimble" ],
                exclude: [
                    "QuickAfterSuiteTests/AfterSuiteTests+ObjC.m",
                    "QuickFocusedTests/FocusedTests+ObjC.m",
                    "QuickTests/FunctionalTests/ObjC",
                    "QuickTests/Helpers/QCKSpecRunner.h",
                    "QuickTests/Helpers/QCKSpecRunner.m",
                    "QuickTests/Helpers/QuickTestsBridgingHeader.h",
                    "QuickTests/QuickConfigurationTests.m",
                ]
            ),
            .testTarget(
                name: "QuickIssue853RegressionTests",
                dependencies: [ "Quick" ]
            ),
        ]
#if os(macOS)
        targets.append(contentsOf: [
            .target(name: "QuickObjCRuntime", dependencies: []),
            .target(name: "Quick", dependencies: [ "QuickObjCRuntime" ]),
        ])
#else
        targets.append(contentsOf: [
            .target(name: "Quick", dependencies: []),
        ])
#endif
        return targets
    }(),
    swiftLanguageVersions: [.v4_2]
)
