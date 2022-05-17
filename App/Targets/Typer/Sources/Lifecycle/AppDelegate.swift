//
//  AppDelegate.swift
//  Typography
//
//  Created by Nikolai Puchko on 10.11.2021.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	private weak var app: UIApplication?

	func application(
		_ app: UIApplication,
		didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		// NOTE: Kinda tricky workaround preventing SwiftUI preview from crashing & decreasing hot reload time
		#if DEBUG
		if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" { return false }
		#endif

		self.app = app

		guard let fileOptions = FirebaseOptions(contentsOfFile: Files.Targets.Typer.Resources.googleServiceInfoPlist.path) else {
			assertionFailure("Couldn't load config file")
			return false
		}
		FirebaseApp.configure(name: firebaseAppName, options: fileOptions)
		return WonderfulBox.bootstrap
	}

	private var sceneDelegate: SceneDelegate? {
		(app ?? .shared).windows
			.compactMap { $0.windowScene?.delegate as? SceneDelegate }
			.first
	}
}

let firebaseAppName = "Typographer"
