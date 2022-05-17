//
//  ImageRecognitionView.swift
//  Typography
//
//  Created by Nikolai Puchko on 05.02.2022.
//

import SwiftUI
import SwiftUIX
import Vision

struct ImageRecognitionView: View {
  @ObservedObject var viewModel: ViewModel

  var body: some View {
    VStack {
      Spacer()
      ZStack {
        Image(uiImage: viewModel.image)
          .resizable()
          .sizeToFit()
          .overlay {
            if let frames = viewModel.frames {
              ZStack {
                ForEach(frames) { frame in
                  RoundedRectangle(cornerRadius: 22)
                    .foregroundColor(.systemGray6.opacity(0.5))
                    .frame(width: frame.width, height: frame.height)
                    .position(x: frame.midX, y: frame.midY)
                  //                                .zIndex(1.0)
                }
              }
            } else {
              ActivityIndicator()
            }
          }
      }
      Spacer()
      HStack {
        Button {
          // dismiss
        } label: {
          Text("Переснять")
            .font(.sfProText(variant: .regular, size: .headingM))
            .foregroundColor(.white)
        }
        Spacer()
      }
      .padding()
    }
    .background(Color.black.edgesIgnoringSafeArea(.all))
    .onAppear {
//      viewModel.fetchFrames()
    }
  }
}

struct ImageRecognitionView_Previews: PreviewProvider {
  static var previews: some View {
		ImageRecognitionView(viewModel: .init(image: TyperAsset.Assets.textformatAlt.image))
  }
}
