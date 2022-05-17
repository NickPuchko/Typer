//
//  SerpState.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation
import IdentifiedCollections

final class SerpState: ObservableObject {
	let filtersState: FiltersState
	@Published var fonts: IdentifiedArrayOf<API.Model.Font>?
	@Published var query: String?

	init(filtersState: FiltersState) {
		self.filtersState = filtersState
	}

	func fetch() {
		Task {
			await MainActor.run {
				fonts = nil
			}
			if let query = query {
				if let response = await API.fontsByName(body: .init(font: query)) {
					await MainActor.run {
						fonts = .init(uniqueElements: response.fonts.unique())
					}
				}
			} else {
				await MainActor.run {
					query = nil
				}
				if let response = await API.fontsByTags(body: .init(listFont: filtersState.selectedFilters)) {
					await MainActor.run {
						fonts = .init(uniqueElements: response.fonts.unique())
					}
				}
			}
		}
	}
}
