//
//  FontPredictions.swift
//  Typography
//
//  Created by Nikolai Puchko on 30.01.2022.
//

import IdentifiedCollections
import SwiftUI
import SwiftUIX

struct FontsComparisonView: View {
	let fonts: IdentifiedArrayOf<API.Model.Font>
	let initialIndex: Int
	let pangram: Pangram
	let image: UIImage?

	var body: some View {
		VStack {
			if let image = image {
				Image(uiImage: image)
					.resizable()
					.sizeToFit()
					.cornerRadius(16)
					.clipped()
			}
			PaginationView(
				axis: .horizontal,
				transitionStyle: .scroll,
				showsIndicators: true
			) {
				ForEach(fonts) { font in
					DetailedFontPrediction(font: font, pangram: pangram)
				}
			}
			.initialPageIndex(initialIndex)
			.pageIndicatorTintColor(.secondary)
			.currentPageIndicatorTintColor(.primary)
			.background(TyperAsset.Assets.backgroundPrimary.color.modern.edgesIgnoringSafeArea(.all))
		}
		.padding(.bottom, 52)
	}
}
