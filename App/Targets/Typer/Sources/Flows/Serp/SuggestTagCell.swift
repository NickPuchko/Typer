////
////  SuggestTagCell.swift
////  Typography
////
////  Created by Nikolai Puchko on 20.02.2022.
////
//
//import SwiftUI
//import SwiftUIX
//
//struct SuggestTagCell: View {
//  let tag: SuggestTag
//  let handleTagSelection: (SuggestTag) -> Void
//
//  var body: some View {
//    Button {
//      handleTagSelection(tag)
//    } label: {
//      HStack {
//        Text(tag.title)
//          .font(.sfProDisplay(variant: .regular, size: .minor))
//        if tag.isSelected {
//          Image(systemName: .xmark)
//        }
//      }
//      .foregroundColor(foreground)
//      .background(background)
//      .padding(.horizontal, hPadding)
//      .padding(.vertical, vPadding)
//    }
//  }
//
//  var background: Color {
//    tag.isSelected ?
//		TyperAsset.Assets.textPrimary.color.modern :
//		TyperAsset.Assets.backgroundPrimary.color.modern
//  }
//
//  var foreground: Color {
//    tag.isSelected ?
//		TyperAsset.Assets.backgroundPrimary.color.modern :
//		TyperAsset.Assets.textPrimary.color.modern
//  }
//}
//
//private let hPadding = 16.0
//private let vPadding = 10.0
//
//struct SuggestTagCell_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//      SuggestTagCell(
//        tag: .init(
//          title: "Антиква",
//          children: [
//            "Новый стиль",
//            "Старый стиль"
//          ], parent: nil,
//          isExclusive: true,
//          infoAction: nil,
//          isSelected: false,
//          isPresented: true
//        ),
//        handleTagSelection: { _ in }
//      )
//      SuggestTagCell(
//        tag: .init(
//          title: "Гротеск",
//          children: ["Bla", "Bla bla"], parent: nil,
//          isExclusive: true,
//          infoAction: nil,
//          isSelected: true,
//          isPresented: true
//        ),
//        handleTagSelection: { _ in }
//      )
//      SuggestTagCell(
//        tag: .init(
//          title: "Шотландские",
//          children: [], parent: nil,
//          isExclusive: true,
//          infoAction: {},
//          isSelected: true,
//          isPresented: true
//        ),
//        handleTagSelection: { _ in }
//      )
//      SuggestTagCell(
//        tag: .init(
//          title: "Шотландские",
//          children: [], parent: nil,
//          isExclusive: true,
//          infoAction: nil,
//          isSelected: true,
//          isPresented: true
//        ),
//        handleTagSelection: { _ in }
//      )
//    }
//  }
//}
