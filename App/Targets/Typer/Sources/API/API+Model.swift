//
//  API+Model.swift
//  Typer
//
//  Created by Nikolai Puchko on 17.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation

extension API {
	enum Model {
		// MARK: Requests -

		struct RequestFontsByName: Codable {
			let font: String
		}

		struct RequestFontsByTags: Codable {
			let listFont: [String]
		}

		struct RequestPhotoBinary: Codable {
			let file: String
		}

		// MARK: - Responses

		struct ResponseFonts: Codable {
			let fonts: [Font]
		}

		struct ResponseGetParams: Codable {
			let feature: [FontFeature]
		}

		struct ResponsePhotoBinary: Codable {
			let fonts: [Font]
			let tags: [String]
		}

		// MARK: - Models

		struct Font: Codable, Identifiable, Hashable {
			let family: String
			let variants: [String]
			let subsets: [String]
			let designers: [String]

			var id: String {
				family
			}

			var googleFontsURL: URL {
				URL(string: "https://fonts.google.com/specimen/\(family)") ?? URL(string: "https://fonts.google.com")!
			}
		}

		struct FontFeature: Codable {
			let name: String
			let value: [String]?
		}
	}
}
