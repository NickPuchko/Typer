////
////  ScannerHelloView.swift
////  Typographer
////
////  Created by Nikolai Puchko on 11.04.2022.
////  Copyright © 2022 com.nickpuchko. All rights reserved.
////
//
//import SwiftUI
//import SwiftUIX
////import BrightroomUI
////import BrightroomEngine
//
//@available(*, deprecated, message: "Sandbox")
//enum ScanningState: Equatable {
//	case waitingForImage
//	case waitingForSelection(UIImage)
//	case readyToProcess(UIImage)
//	case processing
//	case loaded
//}
//
//@available(*, deprecated, message: "Sandbox")
//struct ScannerHelloView: View {
//	private let cancellablesBag = CancellablesBag()
//	@EnvironmentObject var imageState: InputImageState
//	@EnvironmentObject var navigationState: NavigationState
//	@EnvironmentObject var filtersState: FiltersState
//	@State var scanningState: ScanningState = .waitingForImage
//
//	var body: some View {
//		VStack {
//			if let originalImage = imageState.originalImage {
//				HStack {
//					Spacer(minLength: 8)
//					ImageEditor(originalImage: originalImage, inputImageState: imageState)
////						.resizable()
////						.sizeToFit()
////					GeometryReader { geometry in
////						Image(uiImage: originalImage)
////							.resizable()
////							.sizeToFit()
////					}
//					Spacer(minLength: 8)
//				}
//			}
//			Spacer(minLength: 16)
//			HStack(spacing: .zero) {
//				Button {
//					switch scanningState {
//					case .waitingForImage:
//						navigationState.scannerRoutes.presentSheet(.imagePicker(sourceType: .photoLibrary))
//					case .waitingForSelection, .readyToProcess, .processing, .loaded:
//						reset()
//					}
//				} label: {
//					switch scanningState {
//					case .waitingForImage:
//						Text("Открыть галерею")
//					case .waitingForSelection, .readyToProcess:
//						Image(systemName: .arrowClockwise)
//					case .processing, .loaded:
//						EmptyView()
//					}
//				}
//				if scanningState == .waitingForImage {
//					Spacer().frame(width: 16, height: .zero)
//				}
//				Button {
//					switch scanningState {
//					case .waitingForImage:
//						navigationState.scannerRoutes.presentSheet(.imagePicker(sourceType: .camera))
//					case .waitingForSelection, .processing:
//						reset()
//					case let .readyToProcess(image):
//						Task {
//							if let features = await imageState.recogniseFeatures(image: image) {
//								filtersState.filters = .init(
//									uniqueElements: features.map { feature in
//										FontFeature.boolean(.init(title: feature, isSelected: true))
//									}
//								)
//								scanningState = .loaded
//							} else {
//								reset()
//							}
//						}
//					case .loaded:
//						assertionFailure("ScannerHelloView isn't supported!")
////						navigationState.scannerRoutes.push(.fontsList(nil, croppedImage: image))
//					}
//				} label: {
//					switch scanningState {
//					case .waitingForImage:
//						Text("Сделать фото")
//					case .waitingForSelection:
//						EmptyView()
//					case .readyToProcess:
//						Text("Распознать")
//					case .processing:
//						ActivityIndicator()
//					case .loaded:
//						Text("Перейти к результатам")
//					}
//				}
//			}
//			.animation(.easeInOut, value: scanningState)
//			.buttonStyle(MonoButton())
//			.padding(.horizontal, 16)
//			.padding(.bottom, 64)
//		}
//		.onAppear(perform: bind)
//	}
//}
//
//@available(*, deprecated, message: "Sandbox")
//extension ScannerHelloView {
//	func bind() {
//		cancellablesBag.collect {
//			imageState.$croppedImage
//				.receive(on: RunLoop.main)
//				.sink { croppedImage in
//					if let croppedImage = croppedImage {
//						scanningState = .readyToProcess(croppedImage)
//					} else {
//						if let originalImage = imageState.originalImage {
//							scanningState = .waitingForSelection(originalImage)
//						} else {
//							scanningState = .waitingForImage
//						}
//					}
//				}
////			imageState.$originalImage
////				.receive(on: RunLoop.main)
////				.sink { originalImage in
////					if let originalImage = originalImage {
////						scanningState = .waitingForSelection(originalImage)
////						Task {
////							imageState.relativeFrames = await imageState.recogniseFrames(image: originalImage)
////						}
////					} else {
////						scanningState = .waitingForImage
////					}
////				}
//		}
//	}
//
//	func reset() {
//		imageState.originalImage = nil
//		imageState.croppedImage = nil
//	}
//}
