//
//  HomeGraph.swift
//  Typography
//
//  Created by Nikolai Puchko on 11.12.2021.
//

import Firebase
import Foundation
import SwiftUI
import UIKit

enum WonderfulBox {
	static let firApp = FirebaseApp.app(name: firebaseAppName) ?? FirebaseApp.app()!
	static let firAuth = Auth.auth(app: firApp)
	static let authState = AuthState()
	static let authService = AuthService(firAuth: firAuth)
	static let networkServiceCreator = NetworkServiceCreator()
	static let networkService = networkServiceCreator.create(.domain)
	static let filtersState = FiltersState()
	static let serpState = SerpState(filtersState: filtersState)
	static let navigationState = NavigationState()
	static let scannerState = ScannerState()

	static var bootstrap: Bool = {
		authService.subscribe(state: authState)
		setupAppearance()
		Task {
			await filtersState.fetch()
		}
		return true
	}()
}

private func setupAppearance() {
	let appearance = UINavigationBarAppearance()
	appearance.configureWithTransparentBackground()
	appearance.backgroundColor = TyperAsset.Assets.backgroundPrimary.color
	appearance.shadowColor = .clear
	UINavigationBar.appearance().standardAppearance = appearance
	UINavigationBar.appearance().compactAppearance = appearance
	UINavigationBar.appearance().scrollEdgeAppearance = appearance
	UITableView.appearance().separatorStyle = .none
	UITableView.appearance().backgroundColor = .clear
	UITabBarItem.appearance().setTitleTextAttributes(
		[NSAttributedString.Key.font: TyperFontFamily.SFProText.medium.font(size: 11)], for: .normal
	)
}
