//
//  CancellablesBag.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 04.04.2020.
//  Copyright © 2020 Alexey Naumov. All rights reserved.
//

import Combine

final class CancellablesBag {
  fileprivate(set) var subscriptions = Set<AnyCancellable>()

  func cancel() {
    subscriptions.removeAll()
  }

  func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
    subscriptions.formUnion(cancellables())
  }

  @resultBuilder
  enum Builder {
    static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
      cancellables
    }
  }
}

extension AnyCancellable {
  func store(in cancelBag: CancellablesBag) {
    cancelBag.subscriptions.insert(self)
  }
}
