//
//  AuthService.swift
//  Typography
//
//  Created by Nikolai Puchko on 28.11.2021.
//

import Combine
import Foundation

import Firebase
import GoogleSignIn

protocol Authenticator: AnyObject {
  func restoreUser() -> User?
  func signIn()
  func signOut()
  func subscribe(state: AuthState)
}

final class AuthService {
  private let cancellablesBag = CancellablesBag()
  private let firAuth: Auth

	init(firAuth: Auth) {
    self.firAuth = firAuth
  }
}

extension AuthService: Authenticator {
  func restoreUser() -> User? {
    firAuth.currentUser
  }

  func subscribe(state: AuthState) {
    firAuth.addStateDidChangeListener { auth, user in
      Task {
        await state.execute(action: .update(user))
      }
    }

    cancellablesBag.collect {
      state.$loginState.sink { [weak self] userState in
        guard let self = self else { return }
        switch userState {
        case .inited:
          break
        case .pending:
          self.signIn()
        case let .loaded(user):
          if user == nil {
            self.signOut()
          }
        }
      }
    }
  }

  func signIn() {
		let config = GIDConfiguration(clientID: GoogleServiceInfo.clientId)
    // TODO: Pass from coordinator
    guard let vc = UIApplication.shared.topmostViewController else { return }
    GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [weak self] user, error in
      guard
        let self = self,
        error == nil,
        let authentication = user?.authentication,
        let idToken = authentication.idToken
      else {
        return
      }

      let credential = GoogleAuthProvider.credential(
        withIDToken: idToken,
        accessToken: authentication.accessToken
      )
      self.firAuth.signIn(with: credential)
    }
  }

  func signOut() {
    try? firAuth.signOut()
  }
}

final class StubAuthService: Authenticator {
  func subscribe(state: AuthState) {}
  func restoreUser() -> User? { nil }
  func signOut() {}
  func signIn() {}
}
