//
//  FontCategory.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation
import SwiftUI

enum FontCategory {
	static let featureName = "Классификация"

	case sans, sansSerif, monospaced, display, handwritten

	var title: String {
		switch self {
		case .sans:
			return "С засечками"
		case .sansSerif:
			return "Без засечек"
		case .monospaced:
			return "Моноширинный"
		case .display:
			return "Дисплей"
		case .handwritten:
			return "Рукописный"
		}
	}

	var iconName: String {
		switch self {
		case .sans:
			return "sampleSerif"
		case .sansSerif:
			return "sampleSansSerif"
		case .monospaced:
			return "sampleMono"
		case .display:
			return "sampleDisplay"
		case .handwritten:
			return "sampleHandwritten"
		}
	}
}
