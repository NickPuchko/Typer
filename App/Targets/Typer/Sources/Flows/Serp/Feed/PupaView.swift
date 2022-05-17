//
//  PupaView.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI

struct PupaView: View {
  var body: some View {
    HStack(alignment: .center, spacing: 8.0) {
      Text("🔍")
        .font(.system(size: pupaWidth))
        .frame(width: pupaWidth, height: pupaWidth, alignment: .center)
      Text("Определить шрифт")
				.foregroundColor(TyperAsset.Assets.textPrimary.color.modern)
        .font(.sfProDisplay(variant: .semibold, size: .paragraph))
    }
    .padding(.vertical, 16.0)
    .padding(.horizontal, 30.0)
    .background(.systemBackground)
    .clipShape(Capsule())
  }
}

private let pupaWidth: CGFloat = 32.0

struct PupaView_Previews: PreviewProvider {
  static var previews: some View {
    PupaView()
  }
}
