//
//  HomeView.swift
//  Typographer
//
//  Created by Nikolai Puchko on 11.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI

struct HomeView: View {
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		Text("Скоро здесь появится коллекция найденных вами шрифтов - следите за обновлениями")
			.font(.displaySemibold(24))
			.multilineTextAlignment(.center)
			.navigationBarItems(trailing: trailingButton)
	}

	var trailingButton: some View {
		Button {
			navigationState.homeRoutes.push(.profile)
		} label: {
			Image("person")
				.resizable()
				.frame(width: 24.0, height: 24.0, alignment: .center)
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
