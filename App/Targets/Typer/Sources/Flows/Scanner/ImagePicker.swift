//
//  ImagePicker.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
	let sourceType: UIImagePickerController.SourceType
	@EnvironmentObject var navigationState: NavigationState
	@EnvironmentObject var scannerState: ScannerState

	func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = false
		imagePicker.sourceType = sourceType
		imagePicker.delegate = context.coordinator
		return imagePicker
	}

	func updateUIViewController(
		_ uiViewController: UIImagePickerController,
		context: UIViewControllerRepresentableContext<ImagePicker>
	) {}

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		var parent: ImagePicker

		init(_ parent: ImagePicker) {
			self.parent = parent
		}

		func imagePickerController(
			_ picker: UIImagePickerController,
			didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
		) {
			if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
				parent.scannerState.originalImage = image
				parent.navigationState.scannerRoutes.dismiss()
			}
		}

		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			parent.navigationState.scannerRoutes.dismiss()
		}
	}
}
