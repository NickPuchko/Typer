//
//  ImageUploaderService.swift
//  Typography
//
//  Created by Nikolai Puchko on 16.01.2022.
//

import Foundation

final class ImageRecognitionNetworkService: NetworkService {
  func subscribe(to state: ImageState) {
    cancellablesBag.collect {
      state.$fontDescriptionState.sink { [weak self, state] fontDescriptionState in
        if case let .pending(image) = fontDescriptionState {
          Task { [weak self] in
            guard let self = self,
                  var request = Endpoint.mlUpload.request,
                  let imageData = image.pngData(),
                  let payload = try? self.encoder
                  .encode(RequestPayload(file: imageData.base64EncodedString()))
            else {
              return
            }
            request.httpBody = payload
            request.timeoutInterval = 10
            let response = await self.perform(request: request)
            let decodedResponse = await self.decode(ImageState.FontDescription.self, from: response)
            switch decodedResponse {
            case .failure:
              await state.execute(action: .selectFontDescription(nil))
            case let .success(payload):
              await state.execute(action: .selectFontDescription(payload))
            }
          }
        }
      }
    }
  }

  struct RequestPayload: Encodable {
    let file: String
  }
}
