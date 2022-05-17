//
//  FontRenderer.swift
//  Typography
//
//  Created by Nikolai Puchko on 30.01.2022.
//

import SwiftUI

struct FontRenderer: View {
	let text: String
	let familyName: String
	let size: Int

	var body: some View {
		WebView(
			source: .html(
				makeHtmlString(
					text: text,
					familyName: familyName,
					size: size
				)
			)
		)
	}
}

func makeHtmlString(
	text: String,
	familyName: String,
	size: Int = 48
) -> String {
	let familyQuery = familyName.replacingOccurrences(of: " ", with: "+")
	return """
	<html>
	  <head>
	    <link rel="stylesheet"
	          href="https://fonts.googleapis.com/css2?family=\(familyQuery):wght@100..900">
	    <style>
	      body {
	        font-family: '\(familyName)';
	        font-size: \(size)px;
	      }
	    </style>
	  </head>
	  <body>
	    <div>\(text)</div>
	  </body>
	</html>
	"""
}

struct FontRenderer_Previews: PreviewProvider {
	static var previews: some View {
		FontRenderer(text: Pangram.latin.rawValue, familyName: "Anonymous Pro", size: 48)
	}
}
