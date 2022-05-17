//
//  FontsList.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import IdentifiedCollections
import SwiftUI
import SwiftUIX

struct FontsList: View {
	@EnvironmentObject var scannerState: ScannerState
	@EnvironmentObject var navigationState: NavigationState
	@State var isImageHidden = true
	@State var pangram = Pangram.latin
	let fonts: IdentifiedArrayOf<API.Model.Font>
	let predictions: [String]
	let croppedImage: UIImage

	var body: some View {
		VStack {
			VStack(spacing: 20) {
				if isImageHidden {
					Button {
						withAnimation {
							isImageHidden = false
						}
					} label: {
						Text("Посмотреть оригинал")
							.font(.sfProDisplay(variant: .medium, size: .paragraph))
							.foregroundColor(.black)
							.accentColor(.black)
							.padding(.vertical, 10)
							.frame(maxWidth: .infinity)
							.background(
								RoundedRectangle(cornerRadius: 7)
									.fill(Color.white)
									.shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 4)
							)
					}
				} else {
					Image(uiImage: croppedImage)
						.resizable()
						.sizeToFit()
						.cornerRadius(16)
						.clipped()
				}
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(alignment: .top, spacing: 8) {
						ForEach(predictions) { featureName in
							Text(featureName)
								.font(.sfProText(variant: .regular, size: .minor))
								.padding(.vertical, 8)
								.padding(.horizontal, 11)
								.background(TyperAsset.Assets.purple.color.modern)
								.clipShape(Capsule())
						}
					}
				}
			}
			.padding(.horizontal, 8)
			.padding(.vertical, 16)

			SnippetsListView(
				fonts: fonts,
				pangram: pangram) { font in
					navigationState.scannerRoutes.push(
						.fontsComparison(
							fonts,
							initialIndex: fonts.index(id: font.id) ?? 0,
							pangram,
							croppedImage
						)
					)
				}
		}
		.navigationBarItems(trailing: localeButton)
		.padding(.horizontal, 8)
		.padding(.bottom, 52)
		.background(TyperAsset.Assets.backgroundPrimary.color.modern)
	}

	@ViewBuilder private var localeButton: some View {
		Button {
			pangram = pangram.opposite
		} label: {
			Text(pangram.code)
				.font(.sfProText(variant: .regular, size: .minor))
		}
	}
}

extension String: Identifiable {
	public var id: String { self }
}
