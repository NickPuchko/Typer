//
//  Pangram.swift
//  Typography
//
//  Created by Nikolai Puchko on 30.01.2022.
//

import Foundation

enum Pangram: String {
  case cyrillic = "Лингвисты в ужасе: фиг выговоришь этюд: «подъём челябинский, запах щец»"
  case latin = "A mad boxer shot a quick, gloved jab to the jaw of his dizzy opponent"
	
	var code: String {
		switch self {
		case .cyrillic:
			return "Кириллица"
		case .latin:
			return "Латиница"
		}
	}

	var opposite: Self {
		switch self {
		case .cyrillic:
			return .latin
		case .latin:
			return .cyrillic
		}
	}
}
