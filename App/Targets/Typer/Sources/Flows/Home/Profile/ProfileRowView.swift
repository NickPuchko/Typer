//
//  ProfileRowView.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI

struct ProfileRowView: View {
  let title: String

  var body: some View {
    HStack {
      Text(title)
        .font(.sfProDisplay(variant: .regular, size: .paragraph))
        .foregroundColor(.label)
        .padding()
      Spacer()
      Image(systemName: .chevronRight)
        .padding()
				.foregroundColor(TyperAsset.Assets.imageLightGray.color.modern)
    }
    .background(
      .systemBackground
    )
    .cornerRadius(10.0)
  }
}

struct ProfileRowView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileRowView(title: "Избранное")
  }
}
