//
//  FeedView.swift
//  Typography
//
//  Created by Nikolai Puchko on 11.12.2021.
//

import SwiftUI
import SwiftUIX

struct FeedView: View {
	@EnvironmentObject var navigationState: NavigationState
	@EnvironmentObject var filtersState: FiltersState
	@EnvironmentObject var serpState: SerpState
	@State var query: String = ""

	var body: some View {
		ScrollView {
			VStack {
				SearchBar(text: $query.animation(.easeInOut)) { hasChanged in
					if query.count > 2 {}
				} onCommit: {
					serpState.query = query
					serpState.fetch()
					navigationState.serpRoutes.push(.serp)
				}
				.placeholder("Начните писать название шрифта")
				.transition(.opacity)
				.padding(14)
				.background(Color.white)
				.cornerRadius(18)
				if !query.isEmpty {
					Button {
						serpState.query = query
						serpState.fetch()
						navigationState.serpRoutes.push(.serp)
					} label: {
						Text("Искать по названию")
					}
					.buttonStyle(MonoButton())
					.padding()
					.transition(.opacity)
				}
				FontCategoryView()
					.disabled(filtersState.filters.isEmpty)
					.overlay {
						if filtersState.filters.isEmpty {
							ActivityIndicator()
						}
					}
			}
		}
		.padding(.horizontal, 5)
		.background(TyperAsset.Assets.backgroundSecondary.color.modern.edgesIgnoringSafeArea(.all))
		.navigationBarTitle(Text("Typer"), displayMode: .large)
	}
}
