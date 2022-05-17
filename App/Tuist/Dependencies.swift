import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/johnpatrickmorgan/FlowStacks", requirement: .exact("0.1.0")),
            .remote(url: "https://github.com/AndreaMiotto/PartialSheet", requirement: .exact("2.1.14")),
            .remote(url: "https://github.com/SwiftUIX/SwiftUIX", requirement: .exact("0.1.2")),
            .remote(url: "https://github.com/pointfreeco/swift-identified-collections", requirement: .exact("0.3.2")),
            .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .exact("8.14.0")),
            .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .exact("6.1.0")),
            .remote(url: "https://github.com/paololeonardi/WaterfallGrid", requirement: .exact("1.0.1")),
            .remote(url: "https://github.com/onl1ner/TabBar", requirement: .exact("1.2.0")),
            .remote(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", requirement: .exact("2.0.2"))
        ],
        baseSettings: makeFrameworkSettings(),
        targetSettings: makeTargetSettings()
    ),
    platforms: [.iOS]
)

func makeTargetSettings() -> [String: SettingsDictionary] {
    var settings: [String: SettingsDictionary] = [:]
    let allYourDependencyNames = ["SDWebImageSwiftUI"] // add all other dependency names here, this is at least what I am doing
    allYourDependencyNames.forEach { dependency in
        settings[dependency] = makeBaseSettings()
        settings[dependency] =
            [
                "HEADER_SEARCH_PATHS": "$(inherited) $(SRCROOT)/SDWebImage/include/SDWebImage $(SRCROOT)/SDWebImage/Private $(SRCROOT)/SDWebImage/Core $(SRCROOT)/WebImage"
            ]
    }

    return settings
}

func makeFrameworkSettings() -> Settings {
    .settings(
        base: makeFrameworkBaseSettings(),
        configurations: [
            // just an example
            .debug(name: "Debug"),
            .release(name: "AdHoc"),
            .release(name: "Release")
        ]
    )
}

func makeFrameworkBaseSettings() -> SettingsDictionary {
    [
        "FRAMEWORK_SEARCH_PATHS": "$(inherited) $(SYMROOT)/Release$(EFFECTIVE_PLATFORM_NAME)"
    ]
}

func makeBaseSettings() -> SettingsDictionary {
    SettingsDictionary()
        .swiftOptimizeObjectLifetimes(false)
        .bitcodeEnabled(true)
        .merging([
            "OTHER_LDFLAGS": "-ObjC",
            "PUSH_URL_SCHEME": "fressnapfapp",
            "ALWAYS_SEARCH_USER_PATHS": "NO",
        ])
}
