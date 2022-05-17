//
//  SignoutButton.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI

struct PinkBorderedButton: View {
  let title: String

  var body: some View {
    Text(title)
			.foregroundColor(TyperAsset.Assets.buttonPink.color.modern)
      .padding()
      .maxWidth(.infinity)
      .overlay {
        RoundedRectangle(cornerRadius: 10.0)
					.stroke(TyperAsset.Assets.buttonPink.color.modern, lineWidth: 1.0)
      }
  }
}

struct PinkBorderedButton_Previews: PreviewProvider {
  static var previews: some View {
    PinkBorderedButton(title: "Выйти")
  }
}
