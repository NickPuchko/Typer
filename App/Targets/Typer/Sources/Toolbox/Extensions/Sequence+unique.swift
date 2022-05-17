//
//  Sequence+unique.swift
//  Typer
//
//  Created by Nikolai Puchko on 18.04.2022.
//  Copyright © 2022 com.nickpuchko. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
	func unique() -> [Iterator.Element] {
		var seen: Set<Iterator.Element> = []
		return filter { seen.insert($0).inserted }
	}
}
