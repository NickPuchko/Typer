import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
  /// Helper function to create the Project for this ExampleApp
  public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
    let appTarget = makeAppTarget(
      name: name,
      platform: platform,
      dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
    )
    return Project(
      name: name,
      organizationName: "nickpuchko",
      targets: [appTarget] + additionalTargets.map { makeFrameworkTarget(name: $0, platform: platform) }
    )
  }

  // MARK: - Private

  /// Helper function to create a framework target and an associated unit test target
  private static func makeFrameworkTarget(name: String, platform: Platform) -> Target {
    Target(
      name: name,
      platform: platform,
      product: .framework,
      bundleId: "com.nickpuchko.\(name)",
      infoPlist: .default,
      sources: ["Targets/\(name)/Sources/**"],
      resources: [],
      dependencies: []
    )
  }

  /// Helper function to create the application target and the unit test target.
  private static func makeAppTarget(name: String, platform: Platform, dependencies: [TargetDependency]) -> Target {
    let platform: Platform = platform
    let infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UIMainStoryboardFile": "",
      "UILaunchStoryboardName": "LaunchScreen"
    ]
    return Target(
      name: name,
      platform: platform,
      product: .app,
      bundleId: "com.nickpuchko.\(name)",
      deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Targets/\(name)/Sources/**"],
      resources: ["Targets/\(name)/Resources/**"],
//            headers: .headers(
//                public: "Sources/public/**",
//                private: "Sources/private/**",
//                project: "Sources/project/**"
//            ),
      scripts: [
        .post(
          path: "${PODS_ROOT}/FirebaseCrashlytics/run",
          name: "Upload Crashlytics",
          inputPaths: [
            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
            "$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)"
          ],
          basedOnDependencyAnalysis: true
        )
      ],
      dependencies: dependencies
    )
  }
}
