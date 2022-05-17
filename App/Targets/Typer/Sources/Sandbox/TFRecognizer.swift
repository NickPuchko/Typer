//
//  TFManager.swift
//  Typographer
//
//  Created by Nikolai Puchko on 16.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Firebase
import UIKit
import FirebaseMLModelDownloader

final class TFRecognizer {
	private let downloader: ModelDownloader

	init(firApp: FirebaseApp) {
		downloader = ModelDownloader.modelDownloader(app: firApp)
		let downloadConditions = ModelDownloadConditions(allowsCellularAccess: false)
		downloader.getModel(
				name: "modelContrast",
				downloadType: .latestModel,
				conditions: downloadConditions,
				progressHandler: { progress in
					print(progress)
					// Handle progress.
				}
			) { result in
				// Handle download result.
				switch result {
				case let .success(model): // Use model.
					print(model)
					
				case let .failure(error): // Handle error.
					print(error)
					
				}
			}
	}
}
