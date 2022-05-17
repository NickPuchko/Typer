////
////  SuggestTag.swift
////  Typography
////
////  Created by Nikolai Puchko on 20.02.2022.
////
//
//import Foundation
//import IdentifiedCollections
//
//struct SuggestTagsGroup: Identifiable {
//  var id: TagType {
//    type
//  }
//
//  let type: TagType
//  let tags: IdentifiedArrayOf<SuggestTag>
//
//  enum TagType: Identifiable {
//    case classification, typography, alphabet
//
//    var id: Self { self }
//
//    var title: String {
//      switch self {
//      case .classification:
//        return "Классификация"
//      case .typography:
//        return "Типографика"
//      case .alphabet:
//        return "Алфавит"
//      }
//    }
//  }
//}
//
//struct SuggestTag: Identifiable {
//  var id: String {
//    title
//  }
//
//  let title: String
//  let children: [ID]
//  let parent: ID?
//  let isExclusive: Bool
//  let infoAction: (() -> Void)?
//  var isSelected: Bool
//  var isPresented: Bool
//}
