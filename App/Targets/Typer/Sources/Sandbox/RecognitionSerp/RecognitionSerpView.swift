//
//  RecognitionSerpView.swift
//  Typography
//
//  Created by Nikolai Puchko on 16.01.2022.
//

import SwiftUI
import SwiftUIX

struct RecognitionSerpView: View {
  @ObservedObject var imageState: ImageState
  let image: UIImage

  var body: some View {
    ZStack {
			TyperAsset.Assets.backgroundSecondary.color.modern
        .edgesIgnoringSafeArea(.all)
      List {
        VStack {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .cornerRadius(30.0)
            .frame(maxHeight: maxImageHeight)
            .padding()
          switch imageState.fontDescriptionState {
          case .pending, .inited:
            ActivityIndicator()
              .style(.large)
          case let .loaded(fontDescription):
            if let fontDescription = fontDescription {
              ForEach(Array(repeating: fontDescription, count: 10)) {
                FontResultSnippetView(
                  fontsDescription: $0,
                  text: imageState.recognizedText.unwrapped as? String ?? ImageState.FontDescription
                    .mockText
                )
                .frame(maxHeight: 180.0)
              }
            } else {
              Text("Не получилось определить шрифт 😵‍💫")
                .font(.sfProDisplay(variant: .semibold, size: .headerXL))
                .lineLimit(3)
                .padding()
                .background(TyperAsset.Assets.backgroundSecondary.color.modern)
                .cornerRadius(8.0)
            }
          }
        }
        .listRowInsets(.zero)
        .frame(maxWidth: .infinity)
				.background(TyperAsset.Assets.backgroundPrimary.color.modern)
        .animation(.easeOut, value: imageState.fontDescriptionState)
      }
    }
  }
}

private let maxImageHeight: CGFloat = 140.0

private var mockListData: [ImageState.FontDescription] {
  .init(repeating: .mock, count: 10)
}

#if DEBUG
struct RecognitionSerpView_Previews: PreviewProvider {
  static var previews: some View {
    RecognitionSerpView(imageState: .init(), image: UIImage(systemName: "photo")!)
  }
}
#endif
