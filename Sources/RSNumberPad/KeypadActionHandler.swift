//
//  KeypadActionHandler.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import Foundation

protocol KeypadActions {
    var randomKeypad: RandomKeypad { get set }
    func shuffleKeys()
    func getKeyValue(for index: Int) -> KeypadButtonState?
    func handleButtonTap(with title: String)
}

final class KeypadActionHandler: KeypadActions {
    var randomKeypad: RandomKeypad
    private var buttonTapped: ((String) -> Void)?
    
    init(randomKeypad: RandomKeypad = RandomKeypad()) {
        self.randomKeypad = randomKeypad
    }
    
    func shuffleKeys() {
        randomKeypad.shuffleKeypad()
    }
    
    func getKeyValue(for index: Int) -> KeypadButtonState? {
        return randomKeypad.getValue(for: index)
    }
    
    func handleButtonTap(with title: String) {
        buttonTapped?(title)
    }
    
    func setButtonTappedAction(_ action: @escaping (String) -> Void) {
        self.buttonTapped = action
    }
}
