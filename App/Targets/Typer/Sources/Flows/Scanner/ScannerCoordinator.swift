//
//  ScannerCoordinator.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import FlowStacks
import SwiftUI

struct ScannerCoordinator: View {
	@EnvironmentObject var navigationState: NavigationState

	var body: some View {
		Router($navigationState.scannerRoutes) { route, _ in
			switch route {
			case .hello:
				ScannerView()
					.navigationBarHidden(true)
			case let .imagePicker(sourceType):
				ImagePicker(sourceType: sourceType)
					.edgesIgnoringSafeArea(.bottom)
					.environmentObject(navigationState)
					.environmentObject(WonderfulBox.scannerState)
			case let .fontsList(payload, croppedImage):
				if let payload = payload {
					FontsList(
						fonts: .init(uniqueElements: payload.fonts),
						predictions: payload.tags,
						croppedImage: croppedImage
					)
					.navigationBarTitle("", displayMode: .inline)
				} else {
					FailedRecognitionView()
				}
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
		.background(TyperAsset.Assets.backgroundPrimary.color.modern)
	}
}

struct ScannerCoordinator_Previews: PreviewProvider {
	static var previews: some View {
		ScannerCoordinator()
	}
}
