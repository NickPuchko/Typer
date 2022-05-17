//
//  SubtitleButton.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI

struct SubtitleButton: View {
  let title: String
  let subtitle: String

  var body: some View {
    VStack(spacing: 10.0) {
      Text(title)
        .font(.sfProDisplay(variant: .semibold, size: .headingL))
				.foregroundColor(TyperAsset.Assets.textPrimary.color.modern)
      Text(subtitle)
        .font(.sfProDisplay(variant: .semibold, size: .paragraph))
				.foregroundColor(TyperAsset.Assets.textSecondary.color.modern)
    }
    .padding()
		.background(TyperAsset.Assets.backgroundSecondary.color.modern)
    .cornerRadius(22.0)
  }
}

struct SubtitleButton_Previews: PreviewProvider {
  static var previews: some View {
    SubtitleButton(title: "bla", subtitle: "bla bla")
  }
}
