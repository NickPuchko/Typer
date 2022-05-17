//
//  SnippetsListView.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import IdentifiedCollections
import SwiftUI

struct SnippetsListView: View {
	let fonts: IdentifiedArrayOf<API.Model.Font>
	let pangram: Pangram
	let selectAction: (API.Model.Font) -> Void

	var body: some View {
		List(fonts) { font in
			Button {
				selectAction(font)
			} label: {
				FontCellView(font: font, pangram: pangram)
			}
			.listRowBackground(Color.clear)
			.if(.iOS15) { view in
				if #available(iOS 15.0, *) {
					view.listRowSeparator(.hidden)
				}
			}
		}
		.listStyle(.plain)
		.background(TyperAsset.Assets.backgroundPrimary.color.modern)
	}
}
