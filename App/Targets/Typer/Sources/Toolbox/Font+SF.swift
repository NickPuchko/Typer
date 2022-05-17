//
//  Font+SF.swift
//  Typography
//
//  Created by Nikolai Puchko on 06.01.2022.
//

import SwiftUI

extension Font {
	static func displayRegular(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProDisplay.regular.modern(size)
	}
	
	static func displayMedium(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProDisplay.medium.modern(size)
	}
	
	static func displaySemibold(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProDisplay.semibold.modern(size)
	}
	
	static func displayBold(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProDisplay.bold.modern(size)
	}
	
	static func textRegular(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProText.regular.modern(size)
	}
	
	static func textMedium(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProText.medium.modern(size)
	}
	
	static func textSemibold(_ size: CGFloat) -> Font {
		TyperFontFamily.SFProText.semibold.modern(size)
	}
}

private extension TyperFontConvertible {
	func modern(_ size: CGFloat) -> SwiftUI.Font {
		.init(font(size: size))
	}
}

extension Font {
  enum SFProDisplayVariant {
    case regular
    case semibold
    case medium
  }

  enum SFProTextVariant {
    case regular
    case medium
  }

  enum FontSize: CGFloat {
    /// 27
    case headerXL = 27.0
    /// 24
    case headingL = 24.0
    /// 20
    case headingM = 20.0
    /// 18
    case paragraph = 18.0
    /// 16
    case minor = 16.0
		/// 13
		case caption = 13.0
  }

  static func sfProDisplay(variant: SFProDisplayVariant, size: FontSize) -> Font {
    var font: UIFont?
    switch variant {
    case .regular:
      font = TyperFontFamily.SFProDisplay.regular.font(size: size.rawValue)
    case .semibold:
      font = TyperFontFamily.SFProDisplay.semibold.font(size: size.rawValue)
    case .medium:
      font = TyperFontFamily.SFProDisplay.medium.font(size: size.rawValue)
    }
    return Font(font.safe as CTFont)
  }

  static func sfProText(variant: SFProTextVariant, size: FontSize) -> Font {
    var font: UIFont?
    switch variant {
    case .regular:
      font = TyperFontFamily.SFProText.regular.font(size: size.rawValue)
    case .medium:
      font = TyperFontFamily.SFProText.medium.font(size: size.rawValue)
    }
    return Font(font.safe as CTFont)
  }
}

extension Optional where Wrapped == UIFont {
  var safe: Wrapped {
    self ?? .systemFont(ofSize: Font.FontSize.paragraph.rawValue)
  }
}
