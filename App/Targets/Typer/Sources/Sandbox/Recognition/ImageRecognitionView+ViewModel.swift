//
//  ImageRecognitionView+ViewModel.swift
//  Typography
//
//  Created by Nikolai Puchko on 05.02.2022.
//

import Foundation
import SwiftUI
import Vision

extension ImageRecognitionView {
  final class ViewModel: ObservableObject {
    @Published var frames: [CGRect]?
    let image: UIImage

    init(image: UIImage) {
      self.image = image
      frames = []
    }

//    func fetchFrames() {
//      Task {
//        frames = nil
//        frames = await recognize(image: image)
//      }
//    }
  }
}
