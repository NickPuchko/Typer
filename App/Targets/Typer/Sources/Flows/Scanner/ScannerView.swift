//
//  ScannerView.swift
//  Typographer
//
//  Created by Nikolai Puchko on 16.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Brightroom
import SwiftUI
import SwiftUIX

struct ScannerView: View {
	@EnvironmentObject var scannerState: ScannerState
	@EnvironmentObject var navigationState: NavigationState
	@State var isLoading = false

	var body: some View {
		ZStack {
			if let originalImage = scannerState.originalImage {
				let editingStack = EditingStack(imageProvider: ImageProvider(image: originalImage))
				SwiftUIPhotosCropView(editingStack: editingStack) {
					if let croppedImage = try? editingStack.makeRenderer().render().uiImage {
						Task {
							scannerState.originalImage = nil
							isLoading = true
							let recognitionResponse = await API.photoBinary(image: croppedImage)
							isLoading = false
							navigationState.scannerRoutes.push(.fontsList(recognitionResponse, croppedImage: croppedImage))
						}
					}
				}
				.padding(.bottom, 52)
			} else {
				VStack {
					Image(uiImage: TyperAsset.Assets.scanerIllustration.image)
						.resizable()
						.sizeToFit()
					HStack {
						Button {
							navigationState.scannerRoutes.presentSheet(.imagePicker(sourceType: .photoLibrary))
						} label: {
							Text("Открыть галерею")
						}
						Button {
							navigationState.scannerRoutes.presentSheet(.imagePicker(sourceType: .camera))
						} label: {
							Text("Сделать фото")
						}
					}
					.buttonStyle(MonoButton())
					.animation(.easeInOut, value: scannerState.originalImage)
				}
				.padding()
				if isLoading {
					VStack {
						ActivityIndicator()
						Text("Анализируем шрифт...")
							.font(.sfProDisplay(variant: .medium, size: .paragraph))
					}
					.padding()
					.background(BlurEffectView(style: .light).cornerRadius(8))
				}
			}
		}
		.animation(.easeInOut, value: scannerState.originalImage)
	}
}
