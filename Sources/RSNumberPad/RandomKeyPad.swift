//
//  RandomKeyPad.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import Foundation

final class RandomKeyPad {
    private var keypadValues: [[KeyPadButtonState?]] = []
    
    init() {
        initializeKeypad()
    }
    
    private func initializeKeypad() {
        keypadValues = Array(repeating: [KeyPadButtonState?](repeating: nil, count: 3), count: 4)
    }
    
    func shuffleKeypad() {
        var values = Array(0...9)
        values.shuffle()
        
        for i in 0..<values.count {
            keypadValues[i / 3][i % 3] = .number(values[i])
        }
        
        keypadValues[3] = [.random, .number(values.last!), .delete]
    }
    
    func getValue(for index: Int) -> KeyPadButtonState? {
        return keypadValues[index / 3][index % 3]
    }
}
