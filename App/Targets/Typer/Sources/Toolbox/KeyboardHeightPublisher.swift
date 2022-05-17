//
//  KeyboardHeightPublisher.swift
//  Typography
//
//  Created by Nikolai Puchko on 11.12.2021.
//

import Combine
import UIKit

private extension NotificationCenter {
  var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
    let willShow = publisher(for: UIApplication.keyboardWillShowNotification)
      .map { $0.keyboardHeight }
    let willHide = publisher(for: UIApplication.keyboardWillHideNotification)
      .map { _ in CGFloat(0) }
    return Publishers.Merge(willShow, willHide)
      .eraseToAnyPublisher()
  }
}

private extension Notification {
  var keyboardHeight: CGFloat {
    (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
      .cgRectValue.height ?? 0
  }
}
