//
//  KeyPadViewModel.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import Foundation

class KeyPadViewModel {
    var randomKeyPad: RandomKeyPad
    var buttonTapped: ((String) -> Void)?
    
    init(randomKeyPad: RandomKeyPad = RandomKeyPad()) {
        self.randomKeyPad = randomKeyPad
    }
    
    func shuffle() {
        randomKeyPad.shuffleKeypad()
    }
    
    func getValue(for index: Int) -> KeyPadButtonState? {
        return randomKeyPad.getValue(for: index)
    }
    
    func buttonTitleTapped(_ title: String) {
        buttonTapped?(title)
    }
}
