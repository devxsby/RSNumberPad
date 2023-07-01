//
//  RandomKeyPad.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import Foundation

class RandomKeyPad {
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
        
        for row in 0..<3 {
            for column in 0..<3 {
                keypadValues[row][column] = .number(values[row * 3 + column])
            }
        }
        
        keypadValues[3][0] = .random
        keypadValues[3][1] = .number(values[9])
        keypadValues[3][2] = .delete
    }
    
    func getValue(for index: Int) -> KeyPadButtonState? {
        let row = index / 3
        let column = index % 3
        return keypadValues[row][column]
    }
}
