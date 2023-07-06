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
    private let keypadActions: KeypadActions
    
    init(textField: RSNumberPad, actions: KeypadActions) {
        self.textField = textField
        self.keypadActions = actions
    }
    
    func createRandomKeypadView() -> UIView {
        let screenSize = UIScreen.main.bounds
        let keypadView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 240))
        let buttonSize = calculateButtonSize(for: keypadView.bounds)
        
        keypadView.backgroundColor = UIColor.keypadBackgroundColor
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        
        for row in 0..<4 {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 5
            
            for column in 0..<3 {
                let buttonFrame = calculateButtonFrame(for: row, column: column, size: buttonSize, containerBounds: rowStackView.bounds)
                let index = row * 3 + column
                
                if let state = keypadActions.randomKeypad.getValue(for: index) {
                    let button = createButton(frame: buttonFrame, state: state, tag: index)
                    rowStackView.addArrangedSubview(button)
                }
            }
            
            stackView.addArrangedSubview(rowStackView)
        }
        
        keypadView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: keypadView.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: keypadView.trailingAnchor, constant: -5).isActive = true
        stackView.topAnchor.constraint(equalTo: keypadView.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: keypadView.bottomAnchor, constant: -20).isActive = true
        
        return keypadView
    }
    
    func createDoneButtonToolbar() -> UIToolbar {
        let screenSize = UIScreen.main.bounds
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        
        let keyboardDownButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTapDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, keyboardDownButton], animated: false)
        toolbar.backgroundColor = UIColor.keypadBackgroundColor
        toolbar.tintColor = UIColor.buttonTextColor
        
        return toolbar
    }
    
    @objc func didTapKeypadButton(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {
            return
        }
        
        switch buttonTitle {
        case "⟳":
            keypadActions.shuffleKeys()
            textField.updateKeypadView()
        case "⌫":
            textField.deleteBackward()
        default:
            keypadActions.handleButtonTap(with: buttonTitle)
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
        let buttonWidth: CGFloat = (bounds.width - 20 - 5 * 2) / 3
        let buttonHeight: CGFloat = ((bounds.height - 30 - 7 * 3) / 4) - 5
        return CGSize(width: buttonWidth, height: buttonHeight)
    }
    
    private func calculateButtonFrame(for row: Int, column: Int, size: CGSize, containerBounds: CGRect) -> CGRect {
        let columnSpacing: CGFloat = 5
        let rowSpacing: CGFloat = 7
        let x = (CGFloat(column) * (size.width + columnSpacing)) + columnSpacing
        let y = (CGFloat(row) * (size.height + rowSpacing)) + 5
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    private func createButton(frame: CGRect, state: KeypadButtonState, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = frame
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = state.font
        button.layer.cornerRadius = 5
        button.layer.applyShadow()
        button.tag = tag
        button.setTitle(state.title, for: .normal)
        button.addTarget(self, action: #selector(didTapKeypadButton), for: .touchUpInside)
        button.backgroundColor = state.backgroundColor
        button.setTitleColor(state.textColor, for: .normal)
        return button
    }
}
