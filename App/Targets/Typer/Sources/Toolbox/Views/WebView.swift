//
//  WebView.swift
//  Typography
//
//  Created by Nikolai Puchko on 30.01.2022.
//
import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
	enum Source {
		case web(URLRequest)
		case html(String)
	}

	let source: Source

	func makeUIView(context: Context) -> WKWebView {
		let preferences = WKPreferences()
		preferences.javaScriptEnabled = false
		let configuration = WKWebViewConfiguration()
		configuration.preferences = preferences
		let webView = WKWebView(frame: .zero, configuration: configuration)
		webView.autoresizesSubviews = true
		webView.scrollView.isScrollEnabled = false
		webView.isUserInteractionEnabled = false
		return webView
	}

	func updateUIView(_ webView: WKWebView, context: Context) {
		switch source {
		case let .web(request):
			webView.load(request)
		case let .html(html):
//			WKWebsiteDataStore.default().removeData(
//				ofTypes: [
//					WKWebsiteDataTypeDiskCache,
//					WKWebsiteDataTypeMemoryCache,
//					WKWebsiteDataTypeLocalStorage,
//					WKWebsiteDataTypeOfflineWebApplicationCache
//				],
//				modifiedSince: Date(timeIntervalSince1970: 0),
//				completionHandler: {}
//			)
			webView.loadHTMLString(html, baseURL: nil)
		}
	}
}
