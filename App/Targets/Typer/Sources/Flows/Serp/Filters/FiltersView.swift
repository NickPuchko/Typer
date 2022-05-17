//
//  FiltersView.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct FiltersView: View {
	@EnvironmentObject var filtersState: FiltersState
	@EnvironmentObject var serpState: SerpState
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		VStack {
			ScrollView {
				ForEach(filtersState.filters) { feature in
					featureGridView(feature)
					Divider().padding(.vertical, 10)
				}
				Spacer()
			}
			.padding(16)
			.overlay {
				VStack {
					Spacer()
					Button {
						serpState.query = nil
						serpState.fetch()
						if navigationState.serpRoutes.canPush {
							navigationState.serpRoutes.push(.serp)
						} else {
							navigationState.serpRoutes.dismiss()
						}
					} label: {
						Text("Найти подходящий шрифт")
					}
					.buttonStyle(MonoButton())
					.padding(16)
					.opacity(filtersState.hasSelections ? 1 : 0.7)
					.disabled(!filtersState.hasSelections)
					.animation(.easeInOut, value: filtersState.hasSelections)
				}
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.bottom, 52)
		.background(TyperAsset.Assets.backgroundSecondary.color.modern.edgesIgnoringSafeArea(.all))
		.navigationBarTitle("Поиск", displayMode: .inline)
	}

	@ViewBuilder func featureGridView(_ feature: FontFeature) -> some View {
		switch feature {
		case var .boolean(boolean):
			HStack {
				Text(boolean.title)
					.font(.textSemibold(16))
				Spacer()
				Toggle(
					"",
					isOn: Binding(
						get: {
							boolean.isSelected
						},
						set: { isOn in
							boolean.isSelected = isOn
							filtersState.filters[id: boolean.id] = .boolean(boolean)
						}
					)
				)
				.padding(.horizontal)
			}
		case let .categorial(categorial):
			VStack(spacing: .zero) {
				HStack {
					Text(categorial.title)
						.font(.textSemibold(16))
					Spacer()
				}
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(alignment: .top, spacing: 8) {
						ForEach(categorial.values, id: \.0) { selection in
							Button {
								filtersState.toggle(value: selection.key, featureName: categorial.title)
							} label: {
								Text(selection.key)
									.font(.textRegular(17))
									.lineLimit(1)
									.padding(.horizontal, 11)
									.padding(.vertical, 8)
									.background(selection.value ? TyperAsset.Assets.purple.color.modern : .white)
									.clipShape(Capsule())
									.fixedSize(horizontal: false, vertical: true)
							}
							.accentColor(Color.primary)
							.padding(.top, 11)
						}
					}
				}
			}
			.padding(.bottom, 10)
		}
	}
}

struct FiltersView_Previews: PreviewProvider {
	static var previews: some View {
		FiltersView()
	}
}
