//
//  MyFontsCoordinator.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI
import FlowStacks

struct HomeCoordinator: View {
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		Router($navigationState.homeRoutes) { route, _ in
			switch route {
			case .hello:
				HomeView()
					.navigationBarTitle("", displayMode: .inline)
			case .profile:
				ProfileView()
			}
		}
	}
}

struct HomeCoordinator_Previews: PreviewProvider {
	static var previews: some View {
		HomeCoordinator()
	}
}
