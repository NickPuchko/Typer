//
//  UserPermissionsService.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 26.04.2020.
//  Copyright © 2020 Alexey Naumov. All rights reserved.
//

import Foundation
import UserNotifications

enum Permission {
  case pushNotifications
}

extension Permission {
  enum Status: Equatable {
    case unknown
    case notRequested
    case granted
    case denied
  }
}

protocol PermissionsService: AnyObject {
  func resolveStatus(for permission: Permission)
  func request(permission: Permission)
}

final class UserPermissionsService: PermissionsService {
  private let openAppSettings: () -> Void
  private var permissions: [Permission: Permission.Status]

  init(openAppSettings: @escaping () -> Void) {
    self.openAppSettings = openAppSettings
    permissions = [:]
  }

  func resolveStatus(for permission: Permission) {
    guard permissions[permission] == .unknown else { return }
    switch permission {
    case .pushNotifications:
      pushNotificationsPermissionStatus { [weak self] status in
        self?.permissions[permission] = status
      }
    }
  }

  func request(permission: Permission) {
    guard permissions[permission] != .denied else {
      openAppSettings()
      return
    }
    switch permission {
    case .pushNotifications:
      requestPushNotificationsPermission()
    }
  }
}

// MARK: - Push Notifications

extension UNAuthorizationStatus {
  var map: Permission.Status {
    switch self {
    case .denied: return .denied
    case .authorized: return .granted
    case .notDetermined, .provisional, .ephemeral: return .notRequested
    @unknown default: return .notRequested
    }
  }
}

private extension UserPermissionsService {
  func pushNotificationsPermissionStatus(_ resolve: @escaping (Permission.Status) -> Void) {
    let center = UNUserNotificationCenter.current()
    center.getNotificationSettings { settings in
      DispatchQueue.main.async {
        resolve(settings.authorizationStatus.map)
      }
    }
  }

  func requestPushNotificationsPermission() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { isGranted, _ in
      DispatchQueue.main.async {
        self.permissions[.pushNotifications] = isGranted ? .granted : .denied
      }
    }
  }
}

final class StubUserPermissionsService: PermissionsService {
  func resolveStatus(for _: Permission) {}

  func request(permission _: Permission) {}
}
