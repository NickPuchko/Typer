//
//  SceneDelegate.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.11.2021.
//

import Firebase
import PartialSheet
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo _: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		let hostingController = UIHostingController(
			rootView: TabsCoordinator()
				.environmentObject(WonderfulBox.navigationState)
				.environmentObject(WonderfulBox.authState)
				.environmentObject(WonderfulBox.filtersState)
				.environmentObject(WonderfulBox.scannerState)
				.environmentObject(WonderfulBox.serpState)
		)
		window = (scene as? UIWindowScene).map(UIWindow.init(windowScene:))?.then {
			$0.rootViewController = hostingController
			$0.makeKeyAndVisible()
		}
	}
}
