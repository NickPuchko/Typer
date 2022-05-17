//
//  FontCategoryView.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct FontCategoryView: View {
	@EnvironmentObject var navigationState: NavigationState
	@EnvironmentObject var filtersState: FiltersState

	var body: some View {
		VStack(spacing: .zero) {
			Text("Какой шрифт вы ищите?")
				.font(.displaySemibold(22))
				.font(.sfProDisplay(variant: .semibold, size: .headingM))
				.foregroundColor(.primary)
				.padding(.vertical, 8)
			Text("Выберите интересующую вас категорию шрифтов.")
				.font(.textMedium(13))
				.multilineTextAlignment(.center)
				.foregroundColor(.primary)
				.padding(.bottom, 16)
			HStack(spacing: 8) {
				Spacer(minLength: .zero)
				categoryView(.sansSerif)
				categoryView(.sans)
				categoryView(.monospaced)
				Spacer(minLength: .zero)
			}
			.padding(.bottom, 8)
			HStack(spacing: 8) {
				Spacer(minLength: .zero)
				categoryView(.display)
				categoryView(.handwritten)
				categoryView(nil)
				Spacer(minLength: .zero)
			}
		}
		.padding(.bottom, 24)
		.background(Color.white)
		.cornerRadius(18)
	}

	@ViewBuilder func categoryView(_ category: FontCategory?) -> some View {
		Button {
			if let category = category {
				filtersState.toggle(
					value: category.title,
					featureName: FontCategory.featureName,
					forceUpdate: true
				)
			}
			navigationState.serpRoutes.push(.filters)
		} label: {
			VStack(spacing: 7) {
				Image(category?.iconName ?? "sampleOther")
					.fill()
					.padding([.top, .leading, .trailing], 20)
				Spacer(minLength: .zero)
				Text(category?.title ?? "Другие")
					.lineLimit(1)
					.font(.textRegular(13))
					.padding(.bottom, 15)
					.padding(.horizontal, 4)
			}
			.background(TyperAsset.Assets.backgroundSecondary.color.modern)
			.cornerRadius(22)
			.squareFrame(sideLength: 115)
		}
		.accentColor(Color.primary)
	}
}
