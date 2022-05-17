//
//  ScannerState.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import SwiftUI

/// Observable объект, описывает текущее состояние сканирования
final class ScannerState: ObservableObject {
	/// Исходное изображение, полученное с камеры или галереи
	@Published var originalImage: UIImage?
}
