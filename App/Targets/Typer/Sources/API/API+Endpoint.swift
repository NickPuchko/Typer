//
//  API+endpoints.swift
//  Typer
//
//  Created by Nikolai Puchko on 17.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation
import UIKit

/// The dirtiest networker I've ever made
enum API {
	// MARK: - Helpers

	private static func typerURL(path: String) -> URL {
		var components = URLComponents()
		components.scheme = "http"
		components.host = "194.87.92.100"
		components.path = path
		return components.url!
	}

	private static func perform<Response: Codable>(request: URLRequest) async -> Response? {
		await withCheckedContinuation { continuation in
			URLSession.shared.dataTask(with: request) { data, _, _ in
				if let data = data {
					if let response = try? decoder.decode(Response.self, from: data) {
						continuation.resume(returning: response)
					} else {
						print("Failed to decode")
						continuation.resume(returning: nil)
					}
				} else {
					print("Request failed")
					continuation.resume(returning: nil)
				}
			}.resume()
		}
	}

	// MARK: Endpoints -

	static func getParams() async -> Model.ResponseGetParams? {
		let request = URLRequest(url: typerURL(path: "/api/v1/ml/find/parameters/ru/"))
		return await perform(request: request)
	}

	static func fontsByName(body: Model.RequestFontsByName) async -> Model.ResponseFonts? {
		var request = URLRequest(url: typerURL(path: "/api/v1/ml/find/name/"))
		request.httpBody = try? encoder.encode(body)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return await perform(request: request)
	}

	static func fontsByTags(body: Model.RequestFontsByTags) async -> Model.ResponseFonts? {
		var request = URLRequest(url: typerURL(path: "/api/v1/ml/find/tags/ru/"))
		request.httpBody = try? encoder.encode(body)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return await perform(request: request)
	}

	static func photoBinary(image: UIImage) async -> Model.ResponsePhotoBinary? {
		var request = URLRequest(url: typerURL(path: "/api/v1/ml/bin/"))
		if let pngData = image.pngData() {
			let body = Model.RequestPhotoBinary(file: pngData.base64EncodedString())
			request.httpBody = try? encoder.encode(body)
		}
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return await perform(request: request)
	}
}

private let decoder = JSONDecoder()
private let encoder = JSONEncoder()
