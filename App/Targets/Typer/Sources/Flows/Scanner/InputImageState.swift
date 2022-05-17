//
//  InputImageState.swift
//  Typographer
//
//  Created by Nikolai Puchko on 11.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI
import Vision

@available(*, deprecated, message: "Sandbox")
final class InputImageState: ObservableObject {
	@Published var originalImage: UIImage?
	@Published var croppedImage: UIImage?
	@Published var relativeFrames: [RelativeFrame]?

	// TODO: Network call
	func recogniseFeatures(image: UIImage) async -> [String]? {
		try? await Task.sleep(nanoseconds: 1_000_000_000 * 3)
		return ["Grotesque", "Monospaced"]
	}

	func recogniseFrames(image: UIImage) async -> [RelativeFrame]? {
		await withCheckedContinuation { continuation in
			guard let cgImage = image.cgImage else {
				continuation.resume(returning: [])
				return
			}
			let requestHandler = VNImageRequestHandler(cgImage: cgImage)
			let request = VNRecognizeTextRequest { request, error in
				guard let observations = request.results as? [VNRecognizedTextObservation] else {
					continuation.resume(returning: [])
					return
				}
				let frames = observations.compactMap(normalize(observation:))
				print(frames)
				continuation.resume(returning: frames)
			}
			request.recognitionLevel = .accurate
			do {
				try requestHandler.perform([request])
			} catch {
				continuation.resume(returning: [])
			}
		}
	}
}

private func normalize(observation: VNRecognizedTextObservation) -> RelativeFrame? {
	guard let candidate = observation.topCandidates(1).first,
				candidate.confidence > 0.9 else { return nil }
	let stringRange = candidate.string.startIndex..<candidate.string.endIndex
	let boxObservation = try? candidate.boundingBox(for: stringRange)
	guard let boundingBox = boxObservation?.boundingBox else { return nil }
	return RelativeFrame(
		minX: boundingBox.minX,
		minY: boundingBox.minY,
		width: boundingBox.width,
		height: boundingBox.height
	)
}

extension VNRecognizedTextObservation {
	var width: CGFloat {
		topRight.x.distance(to: topLeft.x)
	}

	var height: CGFloat {
		bottomLeft.y.distance(to: topLeft.y)
	}

	var centerX: CGFloat {
		(topLeft.x + topRight.x) / 2
	}

	var centerY: CGFloat {
		(topLeft.y + bottomLeft.y) / 2
	}
}

extension CGRect: Identifiable {
	public var id: String {
		origin.id
	}
}

extension CGPoint: Identifiable {
	public var id: String {
		x.description + y.description
	}
}
