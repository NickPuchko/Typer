////
////  ImageEditorView.swift
////  Typography
////
////  Created by Nikolai Puchko on 16.01.2022.
////
//
//import BrightroomUI
//import SwiftUI
//import SwiftUIX
//
//@available(*, deprecated, message: "Sandbox")
//struct ImageEditor: View {
//	let editingStack: EditingStack
//	let inputImageState: InputImageState
//	let originalImage: UIImage
//
//	init(originalImage: UIImage, inputImageState: InputImageState) {
//		self.inputImageState = inputImageState
//		self.originalImage = originalImage
//		editingStack = EditingStack(imageProvider: ImageProvider(image: originalImage))
//	}
//
//	var body: some View {
//		SwiftUIPhotosCropView(editingStack: editingStack) {
//			if let image = try? editingStack.makeRenderer().render().uiImage {
//				inputImageState.croppedImage = image
//			}
//		}
//	}
//}
