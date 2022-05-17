//
//  NetworkServiceCreator.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

import Combine
import Foundation

protocol NetworkServiceCreating: AnyObject {
  func create<Service: NetworkService>(
    _ service: NetworkServiceType
  ) -> Service
  func createImageLoader(isPersistent: Bool) -> ImageLoadingService
}

final class NetworkServiceCreator<Service: NetworkService>: NetworkServiceCreating {
  private var services = Set<AnyHashable>()

  func create<Service: NetworkService>(
    _ service: NetworkServiceType
  ) -> Service {
    Service(
      configuration: prepareConfiguration(for: service),
      delegate: nil,
      queue: nil
    ).then { service in
      _ = services.insert(service)
    }
  }

  func createImageLoader(isPersistent: Bool) -> ImageLoadingService {
    ImageLoadingService(
      session: .init(configuration: prepareConfiguration(for: .imageLoading(isPersistent: isPersistent)))
    ).then { service in
      _ = services.insert(service)
    }
  }

  private func prepareConfiguration(for service: NetworkServiceType) -> URLSessionConfiguration {
    let configuration: URLSessionConfiguration
    switch service {
    case .domain:
      configuration = .default
      configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
      configuration.urlCache = nil
    case .ephemeral:
      configuration = .ephemeral
    case let .imageLoading(isPersistent):
      configuration = .default
      configuration.urlCache = .init(
        memoryCapacity: Int(50e6),
        diskCapacity: isPersistent ? Int(100e6) : 0
      )
    }
    configuration.waitsForConnectivity = true
    configuration.timeoutIntervalForResource = 30.0
    configuration.httpAdditionalHeaders = defaultHeaders
    return configuration
  }

  private var defaultHeaders: [String: String] {
    [
      "accept": "application/json"
    ]
  }
}
