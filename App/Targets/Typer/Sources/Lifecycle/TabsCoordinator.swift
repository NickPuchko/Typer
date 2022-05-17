//
//  TabsCoordinator.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI
import TabBar

struct TabsCoordinator: View {
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		TabBar(selection: $navigationState.flow, visibility: $navigationState.tabsVisibility) {
			SerpCoordinator()
				.tabItem(for: Flow.serp)
			ScannerCoordinator()
				.tabItem(for: Flow.scanner)
			HomeCoordinator()
				.tabItem(for: Flow.home)
		}
		.accentColor(Color.primary)
	}
}

extension Flow: Tabbable {
	var title: String {
		switch self {
		case .serp:
			return "Поиск"
		case .scanner:
			return "Сканер"
		case .home:
			return "Коллекция"
		}
	}

	var icon: String {
		switch self {
		case .serp:
			return "text.magnifyingglass"
		case .scanner:
			return "camera.viewfinder"
		case .home:
			return "arrow.down.heart"
		}
	}
}

struct TabsCoordinator_Previews: PreviewProvider {
	static var previews: some View {
		TabsCoordinator()
	}
}
