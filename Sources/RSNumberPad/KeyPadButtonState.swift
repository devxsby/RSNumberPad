//
//  KeyPadButtonState.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import UIKit

enum KeyPadButtonState {
    case number(Int)
    case delete
    case random
    
    var title: String {
        switch self {
        case .number(let value):
            return "\(value)"
        case .delete:
            return "⌫"
        case .random:
            return "⟳"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .number:
            return .white
        case .delete, .random:
            return .clear
        }
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
