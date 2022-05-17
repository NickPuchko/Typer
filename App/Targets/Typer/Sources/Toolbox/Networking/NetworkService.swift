//
//  NetworkService.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

import Foundation

enum NetworkServiceType {
  case domain
  case ephemeral
  case imageLoading(isPersistent: Bool)
}

class NetworkService {
  let cancellablesBag = CancellablesBag()
  lazy var decoder = JSONDecoder()
  lazy var encoder = JSONEncoder()
  private(set) var session: URLSession
  private let queue: OperationQueue?

  required init(
    configuration: URLSessionConfiguration,
    delegate: URLSessionDelegate? = nil,
    queue: OperationQueue? = nil
  ) {
    self.queue = queue
    session = .init(
      configuration: configuration,
      delegate: delegate,
      delegateQueue: queue
    )
  }

  func perform(request: URLRequest) async -> Result<Data, NetworkError> {
    await withCheckedContinuation { continuation in
      session.dataTask(with: request) { data, _, error in
        if let error = error {
          continuation.resume(returning: .failure(.generic(error)))
          return
        }
        if let data = data {
          continuation.resume(returning: .success(data))
        } else {
          continuation.resume(returning: .failure(.invalid))
        }
      }.resume()
    }
  }

  func decode<T>(_ type: T.Type, from response: Result<Data, NetworkError>) async -> Result<T, NetworkError>
    where T: Decodable {
    switch response {
    case let .success(data):
      do {
        return .success(try decoder.decode(T.self, from: data))
      } catch {
        return .failure(.decoding(error))
      }
    case let .failure(error):
      return .failure(error)
    }
  }

  public func rebuild(with configuration: URLSessionConfiguration) {
    session = .init(
      configuration: configuration,
      delegate: session.delegate,
      delegateQueue: queue
    )
  }
}

extension NetworkService: Hashable {
  public static func == (lhs: NetworkService, rhs: NetworkService) -> Bool {
    lhs.session == rhs.session
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(session)
  }
}

private let defaultRetryCount: Int = 2
