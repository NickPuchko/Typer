//
//  SerpView.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import IdentifiedCollections
import SwiftUI
import SwiftUIX

struct SerpView: View {
	@EnvironmentObject var filtersState: FiltersState
	@EnvironmentObject var serpState: SerpState
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		VStack {
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(alignment: .top, spacing: 8) {
					ForEach(filtersState.selectedFilters) { selectedFilterName in
						Text(selectedFilterName)
							.font(.textRegular(17))
							.lineLimit(1)
							.padding(.horizontal, 11)
							.padding(.vertical, 8)
							.background(TyperAsset.Assets.purple.color.modern)
							.clipShape(Capsule())
							.fixedSize(horizontal: false, vertical: true)
					}
				}
			}
			.padding(.top, 10)
			.padding(.bottom, 16)
			Spacer(minLength: .zero)
			if let fonts = serpState.fonts {
				SnippetsListView(
					fonts: fonts,
					pangram: .latin
				) { font in
					navigationState.serpRoutes.push(
						.fontsComparison(
							fonts,
							initialIndex: fonts.index(id: font.id) ?? 0,
							.latin,
							nil
						)
					)
				}
			} else {
				ActivityIndicator()
				Spacer()
			}
		}
		.padding(.horizontal, 16)
		.padding(.bottom, 52)
		.background(TyperAsset.Assets.backgroundPrimary.color.modern)
		.navigationBarItems(trailing: openFiltersButton)
	}
	
	@ViewBuilder var openFiltersButton: some View {
		Button {
			navigationState.serpRoutes.presentSheet(.filters)
		} label: {
			Text("Изменить")
				.font(.sfProText(variant: .medium, size: .paragraph))
				.foregroundColor(TyperAsset.Assets.purple.color.modern)
		}

	}
}
