//
//  NavigationState.swift
//  Typographer
//
//  Created by Nikolai Puchko on 11.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import FlowStacks
import IdentifiedCollections
import SwiftUI
import TabBar

final class NavigationState: ObservableObject {
	@Published var flow: Flow
	@Published var tabsVisibility: TabBarVisibility

	@Published var serpRoutes: Routes<Flow.Serp>
	@Published var scannerRoutes: Routes<Flow.Scanner>
	@Published var homeRoutes: Routes<Flow.Home>

	init(
		flow: Flow = .serp,
		tabsVisibility: TabBarVisibility = .visible,
		serpRoutes: Routes<Flow.Serp> = [.root(.feed, embedInNavigationView: true)],
		scannerRoutes: Routes<Flow.Scanner> = [.root(.hello, embedInNavigationView: true)],
		homeRoutes: Routes<Flow.Home> = [.root(.hello, embedInNavigationView: true)]
	) {
		self.flow = flow
		self.tabsVisibility = tabsVisibility
		self.serpRoutes = serpRoutes
		self.scannerRoutes = scannerRoutes
		self.homeRoutes = homeRoutes
	}
}

/// Описывает набор флоу в приложении
enum Flow {
	/// Таб главной приложения, содержит поиск оп названиям и по фильтрам
	case serp
	/// Таб сканирования, содержит ввод и выбор фотографии, поиск по изображению
	case scanner
	/// Таб персонализированного контента пользователя, содержит профиль
	case home

	enum Serp: Equatable {
		///  Стартовый экран флоу поиска
		case feed
		///  Экран с фильтрами, получаемых с бэкенда, ведёт в поиск шрифта по признакам
		case filters
		/// Экран поисковой выдачи
		case serp
		/// Экран сравнения шрифтов
		case fontsComparison(IdentifiedArrayOf<API.Model.Font>, initialIndex: Int, Pangram, UIImage?)
	}

	enum Scanner {
		/// Приветственный экран сканирования шрифта
		case hello
		/// Экран выбора изображения, зависит от выбора источника
		case imagePicker(sourceType: UIImagePickerController.SourceType)
		/// Экран поисковой выдачи поиска по изображению
		case fontsList(API.Model.ResponsePhotoBinary?, croppedImage: UIImage)
		/// Экран сравнения шрифтов
		case fontsComparison(IdentifiedArrayOf<API.Model.Font>, initialIndex: Int, Pangram, UIImage)
	}

	enum Home {
		/// Домашний экран пользователя
		case hello
		/// Экран с персональными данными и входом через Google
		case profile
	}
}
