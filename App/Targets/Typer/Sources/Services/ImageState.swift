//
//  ImageState.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI
import UIKit

final class ImageState: ObservableObject {
  struct FontDescription: Decodable, Equatable, Identifiable {
    let family: String
    let link: String
    let price: String?

    var id: String { link }
  }

  @Published private(set) var imageState: Loadable<UIImage?, DGF> = .inited
  @Published private(set) var fontDescriptionState: Loadable<FontDescription?, UIImage> = .inited
  @Published private(set) var recognizedText: Loadable<String?, DGF> = .inited
}

extension ImageState: Executer {
  enum Action {
    case selectImage(UIImage?)
    case selectCroppedImage(UIImage)
    case selectFontDescription(FontDescription?)
  }

  @MainActor func execute(action: Action) async {
    switch action {
    case let .selectImage(image):
      imageState = .loaded(image)
    case let .selectFontDescription(fontDescription):
      fontDescriptionState = .loaded(fontDescription)
      recognizedText = .loaded(ImageState.FontDescription.mockText)
    case let .selectCroppedImage(image):
      fontDescriptionState = .pending(image)
    }
  }
}

// swiftlint:disable line_length
extension ImageState.FontDescription {
  static let mock = Self(
    family: "Anonymous Pro",
    link: "http://themes.googleusercontent.com/static/fonts/anonymouspro/v3/Zhfjj_gat3waL4JSju74E-V_5zh5b-_HiooIRUBwn1A.ttf",
    price: nil
  )

  static let mockText = "Лингвисты в ужасе: фиг выговоришь этюд: «подъём челябинский, запах щец»."
}
