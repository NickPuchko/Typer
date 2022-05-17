//
//  EmojiButton.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI

struct EmojiButton: View {
  let emoji: String
  let subtitle: String

  var body: some View {
    VStack(spacing: 5.5) {
      Text(emoji)
        .font(.system(size: 55.0))
        .frame(width: emojiWidth, height: emojiWidth, alignment: .center)
      Text(subtitle)
        .font(.sfProDisplay(variant: .semibold, size: .paragraph))
        .lineLimit(1)
				.foregroundColor(TyperAsset.Assets.textSecondary.color.modern)
    }
    .maxWidth(.infinity)
    .padding()
		.background(TyperAsset.Assets.backgroundSecondary.color.modern)
    .cornerRadius(26.0)
  }
}

private let emojiWidth: CGFloat = 55.0

struct EmojiButton_Previews: PreviewProvider {
  static var previews: some View {
    EmojiButton(emoji: "📸", subtitle: "Сделать снимок")
  }
}
