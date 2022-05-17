import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
    name: "Typer",
    organizationName: "com.nickpuchko",
    options: .options(
        textSettings: .textSettings(
            usesTabs: true,
            indentWidth: 2,
            tabWidth: 2,
            wrapsLines: true
        )
    ),
    settings: .settings(
        debug: [
            "OTHER_LDFLAGS": .array(["-ObjC"]),
            "CODE_SIGN_IDENTITY": .string("iOS Developer"),
            "CODE_SIGN_STYLE": .string("Automatic"),
            "DEVELOPMENT_TEAM": .string("LZ34WQHSPQ")
        ],
        release: ["OTHER_LDFLAGS": .array(["-ObjC"])],
        defaultSettings: .recommended
    ),
    targets: [
        Target(
            name: "Typer",
            platform: .iOS,
            product: .app,
            bundleId: "com.nickpuchko.Typer",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            infoPlist: .extendingDefault(with: [
                "CFBundleURLTypes": .array([
                    .dictionary([
                        "CFBundleTypeRole": .string("Editor"),
                        "CFBundleURLIconFile": .string(""),
                        "CFBundleURLName": .string("Sign in with Google"),
                        "CFBundleURLSchemes": .array([
                            .string("com.googleusercontent.apps.39698007536-ufookjfdrlt4bl3qngo55dopllg6nri9")
                        ])
                    ])
                ]),
                "FirebaseAutomaticScreenReportingEnabled": .boolean(true),
                "GoogleUtilitiesAppDelegateProxyEnabled": .boolean(true),
                "UIAppFonts": .array([
                    .string("SF-Pro-Display-Regular.otf"),
                    .string("SF-Pro-Display-Semibold.otf"),
                    .string("SF-Pro-Display-Medium.otf"),
                    .string("SF-Pro-Text-Regular.otf"),
                    .string("SF-Pro-Text-Medium.otf")
                ]),
                "UISupportedInterfaceOrientations": .array([
                    .string("UIInterfaceOrientationPortrait")
                ]),
                "NSAppTransportSecurity": .dictionary([
                    "NSAllowsArbitraryLoads": .boolean(true)
                ]),
                "UIUserInterfaceStyle": .string("light"),
                "NSCameraUsageDescription": .string("Коли просим, значит надо"),
                "UILaunchStoryboardName": "LaunchScreen",
                "UIApplicationSceneManifest": .dictionary([
                    "UIApplicationSupportsMultipleScenes": .boolean(false),
                    "UISceneConfigurations": .dictionary([
                        "UIWindowSceneSessionRoleApplication": .array([
                            .dictionary([
                                "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate"),
                                "UISceneConfigurationName": .string("UISceneConfigurationName")
                            ])
                        ])
                    ])
                ])
            ]),
            sources: "Targets/Typer/Sources/**",
            resources: [
                "Targets/Typer/Resources/**"
            ],
            dependencies: [
                .external(name: "FlowStacks"),
                .external(name: "PartialSheet"),
                .external(name: "SwiftUIX"),
                .external(name: "IdentifiedCollections"),
                .external(name: "FirebaseAuth"),
                .external(name: "FirebaseAnalytics"),
                .external(name: "FirebaseMLModelDownloader"),
                .external(name: "GoogleSignIn"),
                .external(name: "WaterfallGrid"),
                .external(name: "TabBar"),
                .external(name: "SDWebImageSwiftUI")
            ]
        )
    ],
    resourceSynthesizers: [
        .strings(),
        .fonts(),
        .assets(),
        .plists(),
        .files(extensions: ["plist"])
    ]
)
