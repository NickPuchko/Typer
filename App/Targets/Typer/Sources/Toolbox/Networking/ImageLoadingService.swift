//
//  ImageLoadingService.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

import Combine
import UIKit

public final class ImageLoadingService {
  private let cancellablesBag = CancellablesBag()
  private let session: URLSession

  init(session: URLSession) {
    self.session = session
  }

  public func subscribe(
    to publisher: AnyPublisher<Loadable<UIImage?, URL?>, Never>,
    placeholder: UIImage? = nil,
    handleLoaded: @escaping ((UIImage) -> Void)
  ) {
    publisher
      .sink(receiveValue: { [weak self] imageState in
        switch imageState {
        case .loaded, .inited:
          break
        case let .pending(url):
          Task { [weak self] in
            if let self = self,
               let url = url,
               let data = await self.load(request: URLRequest(url: url)),
               let image = UIImage(data: data) {
              handleLoaded(image)
            } else {
              handleLoaded(placeholder ?? UIImage())
            }
          }
        }
      })
      .store(in: cancellablesBag)
  }

  private func load(request: URLRequest) async -> Data? {
    await withCheckedContinuation { continuation in
      session.dataTask(with: request) { data, _, error in
        if let data = data,
           error == nil {
          continuation.resume(returning: data)
        } else {
          continuation.resume(returning: nil)
        }
      }.resume()
    }
  }
}

extension ImageLoadingService: Hashable {
  public static func == (lhs: ImageLoadingService, rhs: ImageLoadingService) -> Bool {
    lhs.session == rhs.session
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(session)
  }
}
