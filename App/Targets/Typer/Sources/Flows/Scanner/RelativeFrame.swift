//
//  RelativeFrame.swift
//  Typographer
//
//  Created by Nikolai Puchko on 16.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import CoreGraphics
import SwiftUI

struct RelativeFrame: Identifiable {
	var id: String {
		"\(minX) \(minY) \(width) \(height)"
	}

	let minX: CGFloat
	let minY: CGFloat
	let width: CGFloat
	let height: CGFloat
}

extension RelativeFrame {
	/// Переводит minX в абсолютные координаты
	/// - Parameter geometry: Объект, описывющий локальную систему координат
	/// - Returns: Приведённая координата
	func minX(in geometry: GeometryProxy) -> CGFloat {
		geometry.size.width * minX
	}
	
	/// Переводит minY в абсолютные координаты
	/// - Parameter geometry: Объект, описывющий локальную систему координат
	/// - Returns: Приведённая координата
	func minY(in geometry: GeometryProxy) -> CGFloat {
		geometry.size.height * minY
	}
	
	/// Переводит width в абсолютные координаты
	/// - Parameter geometry: Объект, описывющий локальную систему координат
	/// - Returns: Приведённая координата
	func width(in geometry: GeometryProxy) -> CGFloat {
		geometry.size.width * width
	}
	
	/// Переводит height в абсолютные координаты
	/// - Parameter geometry: Объект, описывющий локальную систему координат
	/// - Returns: Приведённая координата
	func height(in geometry: GeometryProxy) -> CGFloat {
		geometry.size.height * minY
	}
}
