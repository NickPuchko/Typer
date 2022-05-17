//
//  FontFeature.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation
import OrderedCollections

enum FontFeature: Identifiable {
	struct Categorial {
		var id: String { title }
		let title: String
		var values: OrderedDictionary<String, Bool>

		mutating func toggle(value: String) {
			values[value]?.toggle()
		}
	}

	struct Boolean {
		var id: String { title }
		let title: String
		var isSelected: Bool

		mutating func toggle() {
			isSelected.toggle()
		}
	}

	case boolean(Boolean)
	case categorial(Categorial)

	var id: String {
		switch self {
		case let .boolean(boolean):
			return boolean.id
		case let .categorial(categorial):
			return categorial.id
		}
	}
}
