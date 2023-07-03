//
//  KeyPadActionHandler.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import Foundation

protocol KeyPadActions {
    var randomKeyPad: RandomKeyPad { get set }
    func shuffleKeys()
    func getKeyValue(for index: Int) -> KeyPadButtonState?
    func handleButtonTap(with title: String)
}

final class KeyPadActionHandler: KeyPadActions {
    var randomKeyPad: RandomKeyPad
    private var buttonTapped: ((String) -> Void)?
    
    init(randomKeyPad: RandomKeyPad = RandomKeyPad()) {
        self.randomKeyPad = randomKeyPad
    }
    
    func shuffleKeys() {
        randomKeyPad.shuffleKeypad()
    }
    
    func getKeyValue(for index: Int) -> KeyPadButtonState? {
        return randomKeyPad.getValue(for: index)
    }
    
    func handleButtonTap(with title: String) {
        buttonTapped?(title)
    }
    
    func setButtonTappedAction(_ action: @escaping (String) -> Void) {
        self.buttonTapped = action
    }
}
