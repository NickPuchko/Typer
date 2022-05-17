//
//  FontResultSnippetView.swift
//  Typography
//
//  Created by Nikolai Puchko on 16.01.2022.
//

import SwiftUI

struct FontResultSnippetView: View {
  let fontsDescription: ImageState.FontDescription
  let text: String

  var body: some View {
    VStack(alignment: .leading, spacing: 13.0) {
      Text(text)
        .font(.sfProDisplay(variant: .medium, size: .headingL))
        .lineLimit(3)
      HStack {
        Text(fontsDescription.family)
          .font(.sfProDisplay(variant: .semibold, size: .headingL))
          .lineLimit(1)
        Spacer()
        Text(fontsDescription.price ?? "free")
          .font(.sfProDisplay(variant: .medium, size: .minor))
          .lineLimit(1)
          .padding(.vertical, 8.0)
          .padding(.horizontal, 20.0)
					.background(TyperAsset.Assets.backgroundPrimary.color.modern)
          .cornerRadius(59.0)
      }
    }
    .padding(16.0)
    .background(.systemBackground)
    .cornerRadius(22.0)
  }
}

struct FontResultSnippetView_Previews: PreviewProvider {
  static var previews: some View {
    FontResultSnippetView(fontsDescription: .mock, text: ImageState.FontDescription.mockText)
			.background(TyperAsset.Assets.backgroundPrimary.color.modern)
  }
}
