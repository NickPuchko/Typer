//
//  FontsResultsView.swift
//  Typography
//
//  Created by Nikolai Puchko on 16.01.2022.
//

import SwiftUI

struct FontsResultsView: View {
  let fontsDescription: [ImageState.FontDescription]
  let text: String

  var body: some View {
    List(fontsDescription) {
      FontResultSnippetView(fontsDescription: $0, text: text)
    }
  }
}

struct FontsResultsView_Previews: PreviewProvider {
  static var previews: some View {
    FontsResultsView(fontsDescription: .init([
      .init(family: "Font one", link: "", price: "200 rubasov"),
      .init(family: "Font two", link: "", price: nil)
    ]), text: ImageState.FontDescription.mockText)
  }
}
