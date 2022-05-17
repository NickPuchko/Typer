//
//  AuthState.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import Firebase
import SwiftUI

final class AuthState: ObservableObject {
  @Published private(set) var loginState: Loadable<User?, DGF> = .inited

  var isSigned: Bool {
    switch loginState {
    case .inited, .pending:
      return false
    case let .loaded(user):
      return user != nil
    }
  }
}

extension AuthState: Executer {
  enum Action {
    case update(User?)
    case signIn
    case signOut
  }

  @MainActor func execute(action: Action) async {
    switch action {
    case let .update(user):
      withAnimation {
        loginState = .loaded(user)
      }
    case .signIn:
      withAnimation {
        loginState = .pending(.empty)
      }
    case .signOut:
      withAnimation {
        loginState = .loaded(nil)
      }
    }
  }
}
