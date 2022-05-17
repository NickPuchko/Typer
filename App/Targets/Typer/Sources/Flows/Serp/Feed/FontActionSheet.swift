//
//  FontActionSheet.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import PartialSheet
import SwiftUI

struct FontActionSheet: View {
  @EnvironmentObject var partialSheetManager: PartialSheetManager
  var openImagePicker: ((UIImagePickerController.SourceType) -> Void)?

  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading, spacing: 24.0) {
          Text("Определить шрифт")
            .font(.sfProDisplay(variant: .semibold, size: .headerXL))
          Text("Найти по фото")
            .font(.sfProDisplay(variant: .semibold, size: .headingL))
        }
        .padding(.top, 32.0)
        Spacer()
      }
      HStack(spacing: 8.0) {
        Button {
          partialSheetManager.closePartialSheet()
          openImagePicker?(.camera)
        } label: {
          EmojiButton(emoji: "📸", subtitle: "Сделать снимок")
        }
        Button {
          partialSheetManager.closePartialSheet()
          openImagePicker?(.photoLibrary)
        } label: {
          EmojiButton(emoji: "📎", subtitle: "Открыть гaлерею")
        }
      }
      .maxWidth(.infinity)
      .padding(.bottom)
      Button {
        partialSheetManager.closePartialSheet()
        //
      } label: {
        SubtitleButton(
          title: "Найти по описанию",
          subtitle: "Описание тип по вопросикам и описанию"
        )
      }
    }
    .padding(.horizontal, 16.0)
  }
}

struct FontActionSheet_Previews: PreviewProvider {
  static var previews: some View {
    FontActionSheet()
  }
}
