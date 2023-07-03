//
//  KeypadViewCreator.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import UIKit

protocol KeypadViewCreation {
    func createRandomKeypadView() -> UIView
    func createDoneButtonToolbar() -> UIToolbar
}

@available(iOS 13.0, *)
final class KeypadViewCreator: KeypadViewCreation {
    
    private let textField: RSNumberPad
    private let keyPadActions: KeyPadActions
    
    init(textField: RSNumberPad, actions: KeyPadActions) {
        self.textField = textField
        self.keyPadActions = actions
    }
    
    func createRandomKeypadView() -> UIView {
        let screenSize = UIScreen.main.bounds
        let keypadView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 240))
        let buttonSize = calculateButtonSize(for: keypadView.bounds)
        
        keypadView.backgroundColor = UIColor(red: 219/255, green: 211/255, blue: 217/255, alpha: 0)
        
        for row in 0..<4 {
            for column in 0..<3 {
                let buttonFrame = calculateButtonFrame(for: row, column: column, size: buttonSize)
                let index = row * 3 + column
                
                if let state = keyPadActions.randomKeyPad.getValue(for: index) {
                    let button = createButton(frame: buttonFrame, state: state, tag: index)
                    keypadView.addSubview(button)
                }
            }
        }
        
        return keypadView
    }
    
    func createDoneButtonToolbar() -> UIToolbar {
        let screenSize = UIScreen.main.bounds
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        
        let chevronDownButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, chevronDownButton], animated: false)
        toolbar.tintColor = .black
        
        return toolbar
    }
    
    @objc func didTapKeypadButton(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {
            return
        }
        
        switch buttonTitle {
        case "⟳":
            keyPadActions.shuffleKeys()
            textField.updateKeypadView()
        case "⌫":
            textField.deleteBackward()
        default:
            keyPadActions.handleButtonTap(with: buttonTitle)
            textField.insertText(buttonTitle)
        }
    }
    
    @objc func didTapDoneButton() {
        textField.resignFirstResponder()
    }
}

// MARK: - UI & Layout

extension KeypadViewCreator {
    
    private func calculateButtonSize(for bounds: CGRect) -> CGSize {
        let buttonWidth: CGFloat = (bounds.width - 20) / 3
        let buttonHeight: CGFloat = ((bounds.height - 30) / 4) - 5
        return CGSize(width: buttonWidth, height: buttonHeight)
    }
       
    private func calculateButtonFrame(for row: Int, column: Int, size: CGSize) -> CGRect {
        let columnSpacing: CGFloat = 5
        let rowSpacing: CGFloat = 7
        let x = (CGFloat(column) * (size.width + columnSpacing)) + columnSpacing
        let y = (CGFloat(row) * (size.height + rowSpacing)) + 5
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    private func createButton(frame: CGRect, state: KeyPadButtonState, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = frame
        button.titleLabel?.font = state.font
        button.layer.cornerRadius = 5
        button.layer.applyShadow()
        button.tintColor = .black
        button.tag = tag
        button.setTitle(state.title, for: .normal)
        button.addTarget(self, action: #selector(didTapKeypadButton), for: .touchUpInside)
        button.backgroundColor = state.backgroundColor
        return button
    }
}
