//
//  Skeleton.swift
//  Typography
//
//  Created by Nikolai Puchko on 30.01.2022.
//

import SwiftUI

struct Skeleton: View {
  @State var opacity: Double = 0.5
  let cornerRadius: Double

  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .foregroundColor(Color.systemGray3)
      .opacity(opacity)
      .onAppear {
        withAnimation(.default.repeatForever(autoreverses: true).speed(0.5)) {
          opacity = 1.0
        }
      }
  }
}

struct Skeleton_Previews: PreviewProvider {
  static var previews: some View {
    Skeleton(cornerRadius: 30)
      .frame(width: 200, height: 50)
  }
}
