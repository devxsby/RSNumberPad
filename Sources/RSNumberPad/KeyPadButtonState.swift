//
//  KeyPadButtonState.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import UIKit

@frozen
enum KeyPadButtonState {
    case number(Int)
    case random
    case delete
    
    var title: String {
        switch self {
        case .number(let value):
            return "\(value)"
        case .random:
            return "⟳"
        case .delete:
            return "⌫"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .number:
            return UIColor.buttonBackgroundColor
        case .random, .delete:
            return .clear
        }
    }
    
    var textColor: UIColor {
        return UIColor.buttonTextColor
    }
    
    var font: UIFont {
        switch self {
        case .random:
            return UIFont.systemFont(ofSize: 36, weight: .regular)
        default:
            return UIFont.systemFont(ofSize: 22, weight: .regular)
        }
    }
}
