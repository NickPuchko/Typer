//
//  FailedRecognitionView.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI

struct FailedRecognitionView: View {
	@State var isSampleImagePresented = false
	var body: some View {
		VStack {
			Text("Не удалось распознать шрифт. Попробуем ещё раз?")
				.font(.sfProDisplay(variant: .semibold, size: .headingL))
				.multilineTextAlignment(.center)
			Button {
				isSampleImagePresented.toggle()
			} label: {
				Text(isSampleImagePresented ? "Скрыть пример" : "Показать пример")
			}
			.buttonStyle(MonoButton())
			if isSampleImagePresented {
				Image("HotToMakePhotoSample")
					.resizable()
					.sizeToFit()
					.cornerRadius(16)
					.clipped()
					.transition(.move(edge: .bottom))
			}
		}
		.animation(.easeInOut, value: isSampleImagePresented)
		.padding()
		.padding(.bottom, 52)
	}
}

struct FailedRecognitionView_Previews: PreviewProvider {
	static var previews: some View {
		FailedRecognitionView()
	}
}
