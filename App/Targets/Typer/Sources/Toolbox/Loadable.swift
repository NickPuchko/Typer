//
//  Loadable.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

public enum Loadable<Response, Request>: Equatable where Response: Equatable, Request: Equatable {
  case inited
  case pending(Request)
  case loaded(Response)

  public var unwrapped: Response? {
    if case let .loaded(value) = self {
      return value
    } else {
      return nil
    }
  }
}

/// Use this enum when you **Don't Give a Fuck** about its payload
public enum DGF: Equatable {
  case empty
}
