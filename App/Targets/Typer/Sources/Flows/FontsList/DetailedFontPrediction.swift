//
//  DetailedFontPrediciton.swift
//  Typography
//
//  Created by Nikolai Puchko on 30.01.2022.
//

import SwiftUI
import SwiftUIX

struct DetailedFontPrediction: View {
	let font: API.Model.Font
	let pangram: Pangram
	@State var weight: Double = normalWeight

	var body: some View {
		VStack {
			HStack {
				Text(font.family)
					.font(.sfProText(variant: .medium, size: .headerXL))
				Spacer()
			}
			FontRenderer(text: pangram.rawValue, familyName: font.family, size: 72)
				.frame(height: rendererHeight)
				.padding()
				.background(Color.systemBackground)
				.cornerRadius(renderCornerRadius)
			HStack {
				Slider(value: $weight, in: minWeight...maxWeight, step: weightStep)
				Text(Font.Weight(weight: Int(weight)).description)
					.fontWeight(.init(weight: Int(weight)))
					.padding()
			}
			.disabled(true)
			Spacer()
			if UIApplication.shared.canOpenURL(font.googleFontsURL) {
				LinkPresentationView(url: font.googleFontsURL, metadata: nil) {
					Skeleton(cornerRadius: renderCornerRadius)
				}
				.frame(height: rendererHeight)
			}

			Spacer()
		}
		.padding()
		.background(TyperAsset.Assets.backgroundPrimary.color.modern.edgesIgnoringSafeArea(.all))
	}
}

extension Font.Weight: CustomStringConvertible {
	init(weight: Int) {
		switch weight {
		case 100: self = Self.thin
		case 200: self = Self.ultraLight
		case 300: self = Self.light
		case 400: self = Self.regular
		case 500: self = Self.medium
		case 600: self = Self.semibold
		case 700: self = Self.bold
		case 800: self = Self.heavy
		case 900: self = Self.black
		default: self = Self.regular
		}
	}

	public var description: String {
		switch self {
		case .thin: return "thin"
		case .ultraLight: return "ultraLight"
		case .light: return "light"
		case .regular: return "regular"
		case .medium: return "medium"
		case .semibold: return "semibold"
		case .bold: return "bold"
		case .heavy: return "heavy"
		case .black: return "black"
		default: return "regular"
		}
	}
}

private let weightStep = 100.0
private let minWeight = 100.0
private let maxWeight = 900.0
private let normalWeight = 400.0

private let rendererHeight = 100.0
private let renderCornerRadius = 30.0
