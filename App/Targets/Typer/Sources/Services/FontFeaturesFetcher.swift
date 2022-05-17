////
////  FontFeaturesFetcher.swift
////  Typographer
////
////  Created by Nikolai Puchko on 09.04.2022.
////  Copyright © 2022 com.nickpuchko. All rights reserved.
////
//
//import Foundation
//
//final class FontFeaturesFetcher {
//	private let networkService: NetworkService
//	private let filtersState: FiltersState
//
//	init(networkService: NetworkService, filtersState: FiltersState) {
//		self.networkService = networkService
//		self.filtersState = filtersState
//	}
//
//	func fetchFeatures() async {
//		filtersState.filters = [
//			.categorial(.init(
//				title: "Категория",
//				values:
//				[
//					"Антиква": false,
//					"Гротеск": false,
//					"Моно": false,
//					"Акцидентный": false,
//					"Рукописный": false
//				]
//			)),
//			.boolean(.init(title: "Контраст", isSelected: false)),
//			.boolean(.init(title: "Капитель", isSelected: false))
//		]
//	}
//}
