//
//  FontCellView.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI

struct FontCellView: View {
	let font: API.Model.Font
	let pangram: Pangram

	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			Text(font.family)
				.font(.sfProDisplay(variant: .regular, size: .headingM))
				.padding(.bottom, 4)
			if let designer = font.designers.first {
				Text(designer)
					.font(.sfProText(variant: .medium, size: .caption))
					.padding(.bottom, 18)
			}
			FontRenderer(text: pangram.rawValue, familyName: font.family, size: 72)
				.frame(height: 80)
		}
		.padding(.vertical, 20)
		.padding(.horizontal, 12)
		.background(
			RoundedRectangle(cornerRadius: 17)
				.fill(Color.white)
				.shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 4)
		)
	}
}

struct FontCellView_Previews: PreviewProvider {
	static var previews: some View {
		FontCellView(
			font: .init(
				family: "Open Sans",
				variants: [],
				subsets: [],
				designers: ["Steve Mateson"]
			),
			pangram: .latin
		)
	}
}
