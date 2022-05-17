//
//  FiltersState.swift
//  Typographer
//
//  Created by Nikolai Puchko on 09.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation
import IdentifiedCollections
import OrderedCollections

final class FiltersState: ObservableObject {
	@Published var filters: IdentifiedArrayOf<FontFeature>

	init() {
		filters = .init()
	}
	
	var hasSelections: Bool {
		filters.elements.contains { feature in
			switch feature {
			case let .boolean(boolean):
				return boolean.isSelected
			case let .categorial(categorial):
				return categorial.values.contains { key, value in
					value
				}
			}
		}
	}
	
	var selectedFilters: [String] {
		var selections: [String] = []
		filters.elements.forEach { feature in
			switch feature {
			case let .boolean(boolean):
				if boolean.isSelected {
					selections.append(boolean.title)
				}
			case let .categorial(categorial):
				categorial.values.forEach { name, isSelected in
					if isSelected {
						selections.append(name)
					}
				}
			}
		}
		return selections
	}

	func fetch() async {
		if let fetchParams = await API.getParams() {
			await MainActor.run {
				filters = .init(
					uniqueElements: fetchParams.feature.map { feature in
						if let values = feature.value {
							var valuesOrderedMap = OrderedDictionary<String, Bool>()
							values.forEach { valuesOrderedMap[$0] = false }
							return FontFeature.categorial(.init(title: feature.name, values: valuesOrderedMap))
						} else {
							return FontFeature.boolean(.init(title: feature.name, isSelected: false))
						}
					}
				)
			}
		}
	}

	func toggle(value: String, featureName: String, forceUpdate: Bool = false) {
		if case var .categorial(category) = filters[id: featureName] {
			if forceUpdate {
				category.values[value] = true
			} else {
				category.toggle(value: value)
			}
			filters[id: featureName] = .categorial(category)
		}
	}

	// Duplicate
//	var selectedFilters: [String] {
//		var selections: [String] = []
//		for filter in filters {
//			switch filter {
//			case let .boolean(boolean):
//				if boolean.isSelected {
//					selections.append(boolean.title)
//				}
//			case let .categorial(categorial):
//				selections += categorial.values.compactMap { $1 ? $0 : nil }
//			}
//		}
//		return selections
//	}
}

extension OrderedDictionary: RandomAccessCollection {
	public subscript(position: Int) -> (key: Key, value: Value) {
		let value = elements[position]
		return (value.key, value.value)
	}

	public var startIndex: Int {
		0
	}

	public var endIndex: Int {
		count
	}
}
