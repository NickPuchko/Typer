//
//  NetworkRequestBuilder.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

import Foundation

enum Endpoint {
  case mlUpload
  case fontCss(family: String)

  var host: String {
    switch self {
    case .mlUpload:
      return defaultHost
    case .fontCss:
      return googleFontsHost
    }
  }

  var path: String {
    switch self {
    case .mlUpload:
      return "/api/v1/ml/bin/"
    case .fontCss:
      return "/css2"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .mlUpload:
      return .post
    case .fontCss:
      return .get
    }
  }

  var headers: [String: String] {
    switch self {
    case .mlUpload:
      let boundary = "Boundary-\(UUID().uuidString)"
      return [contentType: "multipart/form-data; boundary=\(boundary)"]
    case .fontCss:
      return [:]
    }
  }

  var queryItems: [URLQueryItem] {
    switch self {
    case .mlUpload:
      return []
    case let .fontCss(family):
      return [
        URLQueryItem(name: "family", value: family)
      ]
    }
  }

  var url: URL? {
    var components = URLComponents()
    components.scheme = httpsScheme
    components.host = host
    components.path = path
    components.queryItems = queryItems
    return components.url
  }

  var request: URLRequest? {
    guard let url = url else { return nil }
    return URLRequest(url: url).with {
      $0.httpMethod = method.rawValue
      $0.allHTTPHeaderFields = headers
    }
  }
}

private let httpsScheme = "https"
private let defaultHost = "194.87.92.100" //"findfont.auditory.ru"
private let googleFontsHost = "fonts.googleapis.com"
private let contentType = "Content-Type"
