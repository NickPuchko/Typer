//
//  ViewHelpers.swift
//  Typography
//
//  Created by Николай Пучко on 28.11.2021.
//

import SwiftUI
import UIKit

extension Optional where Wrapped == UIImage {
	var safe: Wrapped {
		self ?? .init(systemName: "photo")!
	}
}

extension Optional where Wrapped == UIColor {
	var safe: Wrapped {
		self ?? .black
	}
}

extension UIColor {
	var modern: Color {
		.init(self)
	}
}

extension View {
	@ViewBuilder
	func `if`<Content: View>(
		_ condition: @autoclosure @escaping () -> Bool,
		@ViewBuilder content: (Self) -> Content
	) -> some View {
		if condition() {
			content(self)
		} else {
			self
		}
	}

	@ViewBuilder
	func `if`<Value, Content: View>(
		`let` value: Value?,
		@ViewBuilder content: (_ view: Self, _ value: Value) -> Content
	) -> some View {
		if let value = value {
			content(self, value)
		} else {
			self
		}
	}

	@ViewBuilder
	func ifNot<Content: View>(
		_ notCondition: @autoclosure @escaping () -> Bool,
		@ViewBuilder content: (Self) -> Content
	) -> some View {
		if notCondition() {
			self
		} else {
			content(self)
		}
	}

	@ViewBuilder
	func then<Content: View>(@ViewBuilder content: (Self) -> Content) -> some View {
		content(self)
	}
}

extension Bool {
	static var iOS13: Bool {
		guard #available(iOS 14, *) else {
			return true
		}
		return false
	}
	
	static var iOS15: Bool {
		if #available(iOS 15, *) {
			return true
		} else {
			return false
		}
	}
}
