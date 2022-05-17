//
//  AnalyticsEvent.swift
//  Typography
//
//  Created by Николай Пучко on 27.11.2021.
//

import FirebaseAnalytics

enum AnalyticsEvent: String {
  case failedToLaunchFirebase

  func report() {
    Analytics.logEvent(rawValue, parameters: nil)
  }
}
