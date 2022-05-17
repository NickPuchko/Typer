//
//  HomeCoordinatorView.swift
//  Typography
//
//  Created by Nikolai Puchko on 11.12.2021.
//

import AVFoundation
import FlowStacks
import IdentifiedCollections
import PartialSheet
import SwiftUI

struct SerpCoordinator: View {
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		Router($navigationState.serpRoutes) { route, _ in
			switch route {
			case .feed:
				FeedView()
			case .filters:
				FiltersView()
			case .serp:
				SerpView()
			case let .fontsComparison(fonts, initialIndex, pangram, image):
				FontsComparisonView(
					fonts: fonts,
					initialIndex: initialIndex,
					pangram: pangram,
					image: image
				)
				.navigationBarTitle("", displayMode: .inline)
			}
		}
	}
}

// partialSheetManager.showPartialSheet {
//	FontActionSheet().then {
//		$0.openImagePicker = pushImagePicker(sourceType:)
//	}
// }
//	.addPartialSheet(style: PartialSheetStyle(
//		background: .solid(Color(UIColor.tertiarySystemBackground)),
//		handlerBarStyle: .none,
//		iPadCloseButtonColor: Color(UIColor.systemGray2),
//		enableCover: true,
//		coverColor: Color.black.opacity(0.4),
//		blurEffectStyle: nil,
//		cornerRadius: 10,
//		minTopDistance: 110
//	))
//
// if UIImagePickerController.isSourceTypeAvailable(sourceType) {
//	routes.push(.imagePicker(sourceType: sourceType))
// }
// cancellablesBag.collect {
//	graph.imageState.$fontDescriptionState.sink { fontDescriptionState in
//		if case let .pending(image) = fontDescriptionState {
//			routes.push(.serp(image))
//		}
//	}
// }

//#if DEBUG
//let predictions = IdentifiedArrayOf<FontPrediction>(uniqueElements: [
//	.init(
//		family: "Anonymous Pro",
//		url: .init(string: "https://fonts.google.com/specimen/Anonymous+Pro")!,
//		id: 0
//	),
//	.init(
//		family: "Supermercado One",
//		url: .init(string: "https://fonts.google.com/specimen/Anonymous+Pro")!,
//		id: 1
//	),
//	.init(
//		family: "Montserrat",
//		url: .init(string: "https://fonts.google.com/specimen/Anonymous+Pro")!,
//		id: 2
//	),
//	.init(
//		family: "Oswald",
//		url: .init(string: "https://fonts.google.com/specimen/Anonymous+Pro")!,
//		id: 3
//	),
//	.init(
//		family: "Merriweather",
//		url: .init(string: "https://fonts.google.com/specimen/Anonymous+Pro")!,
//		id: 4
//	),
//	.init(
//		family: "Open Sans Condensed",
//		url: .init(string: "https://fonts.google.com/specimen/Anonymous+Pro")!,
//		id: 5
//	)
//])
//#endif
