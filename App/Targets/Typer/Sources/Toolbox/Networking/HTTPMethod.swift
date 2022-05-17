//
//  HTTPMethod.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

// SOURCE: https://datatracker.ietf.org/doc/html/rfc7231#section-4.3

public enum HTTPMethod: String {
  case connect = "CONNECT"
  case delete = "DELETE"
  case get = "GET"
  case head = "HEAD"
  case options = "OPTIONS"
  case patch = "PATCH"
  case post = "POST"
  case put = "PUT"
  case trace = "TRACE"
}
