//
//  MonoButton.swift
//  Typographer
//
//  Created by Nikolai Puchko on 11.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI

struct MonoButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.textSemibold(16))
			.foregroundColor(.white)
			.padding(.vertical, 16)
			.padding(.horizontal, 11)
			.frame(maxWidth: .infinity)
			.background(Color.black)
			.cornerRadius(7)
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
	}
}
