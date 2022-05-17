////
////  SerpView+ViewModel.swift
////  Typography
////
////  Created by Nikolai Puchko on 20.02.2022.
////
//
//import IdentifiedCollections
//import SwiftUI
//
//extension SuggestView {
//  final class ViewModel: ObservableObject {
//    @Published var classifications: IdentifiedArrayOf<SuggestTag>
//    @Published var typographies: IdentifiedArrayOf<SuggestTag>
//    @Published var subsets: IdentifiedArrayOf<SuggestTag>
//
//    init(
//      classifications: IdentifiedArrayOf<SuggestTag> = .init(),
//      typographies: IdentifiedArrayOf<SuggestTag> = .init(),
//      subsets: IdentifiedArrayOf<SuggestTag> = .init()
//    ) {
//      self.classifications = classifications
//      self.typographies = typographies
//      self.subsets = subsets
//    }
//
//    func select(tag: SuggestTag, type: SuggestType) {
//      switch type {
//      case .classification:
//        classifications[id: tag.id]?.isSelected.toggle()
//        tag.children.forEach { childrenTag in
//          classifications[id: childrenTag]?.isPresented = true
//        }
//        if tag.isExclusive,
//           let parentID = tag.parent,
//           let neighbours = (classifications[id: parentID]?.children.compactMap {
//             classifications[id: $0]?.id
//           }) {
//          neighbours.forEach {
//            if $0 != tag.id {
//              classifications[id: $0]?.isPresented = false
//            }
//          }
//        }
//      case .typography:
//        typographies[id: tag.id]?.isSelected.toggle()
//        tag.children.forEach { childrenTag in
//          typographies[id: childrenTag]?.isPresented = true
//        }
//        if tag.isExclusive,
//           let parentID = tag.parent,
//           let neighbours = (typographies[id: parentID]?.children.compactMap {
//             typographies[id: $0]?.id
//           }) {
//          neighbours.forEach {
//            if $0 != tag.id {
//              typographies[id: $0]?.isPresented = false
//            }
//          }
//        }
//      case .subset:
//        subsets[id: tag.id]?.isSelected.toggle()
//      }
//    }
//
//    func deselect(tag: SuggestTag, type: SuggestType, initial: Bool) {
//      switch type {
//      case .classification:
//        classifications[id: tag.id]?.isSelected = false
//        tag.children.forEach { childrenTag in
//          if let children = classifications[id: childrenTag] {
//            deselect(tag: children, type: .classification, initial: false)
//            classifications[id: childrenTag]?.isPresented = false
//          }
//        }
//        if tag.isExclusive,
//           let parentID = tag.parent,
//           let neighbours = (classifications[id: parentID]?.children.compactMap {
//             classifications[id: $0]?.id
//           }) {
//          neighbours.forEach {
//            if $0 != tag.id {
//              classifications[id: $0]?.isPresented = initial
//            }
//          }
//        }
//      case .typography:
//        typographies[id: tag.id]?.isSelected = false
//        tag.children.forEach { childrenTag in
//          if let children = typographies[id: childrenTag] {
//            deselect(tag: children, type: .typography, initial: false)
//            typographies[id: childrenTag]?.isPresented = false
//          }
//        }
//        if tag.isExclusive,
//           let parentID = tag.parent,
//           let neighbours = (typographies[id: parentID]?.children.compactMap {
//             typographies[id: $0]?.id
//           }) {
//          neighbours.forEach {
//            if $0 != tag.id {
//              typographies[id: $0]?.isPresented = initial
//            }
//          }
//        }
//      case .subset:
//        subsets[id: tag.id]?.isSelected = false
//      }
//    }
//  }
//}
//
//enum SuggestType {
//  case classification, typography, subset
//
//  var title: String {
//    switch self {
//    case .classification:
//      return "Классификация"
//    case .typography:
//      return "Типографика"
//    case .subset:
//      return "Алфавит"
//    }
//  }
//}
