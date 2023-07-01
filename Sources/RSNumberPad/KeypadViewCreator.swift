//
//  KeypadViewCreator.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/01.
//

import UIKit

class KeypadViewCreator {
    
    private let textField: RSNumberPad
    private let viewModel: KeyPadViewModel
    
    init(textField: RSNumberPad, viewModel: KeyPadViewModel) {
        self.textField = textField
        self.viewModel = viewModel
    }
    
    private func createButton(frame: CGRect, state: KeyPadButtonState, tag: Int, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = frame
        button.titleLabel?.font = state.font
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 2
        button.layer.masksToBounds = false
        button.tintColor = .black
        button.tag = tag
        button.setTitle(state.title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.backgroundColor = state.backgroundColor
        return button
    }
    
    func createRandomKeypadView() -> UIView {
        let keypadView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: 240))
        let buttonWidth: CGFloat = (keypadView.bounds.width - 20) / 3
        let buttonHeight: CGFloat = ((keypadView.bounds.height - 30) / 4) - 5
        let columnSpacing: CGFloat = 5
        let rowSpacing: CGFloat = 7
        
        keypadView.backgroundColor = UIColor(red: 219/255, green: 211/255, blue: 217/255, alpha: 0)
        
        for row in 0..<4 {
            for column in 0..<3 {
                let x = (CGFloat(column) * (buttonWidth + columnSpacing)) + columnSpacing
                let y = (CGFloat(row) * (buttonHeight + rowSpacing)) + 5
                let frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
                let index = row * 3 + column
                
                if let state = viewModel.randomKeyPad.getValue(for: index) {
                    let button = createButton(frame: frame, state: state, tag: index, target: self, action: #selector(didTapKeypadButton))
                    keypadView.addSubview(button)
                }
            }
        }
        
        return keypadView
    }
    
    func createDoneButtonToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: 44))
        
        let chevronDownButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down.to.line.compact"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
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
            viewModel.shuffle()
            textField.updateKeypadView()
        case "⌫":
            textField.deleteBackward()
        default:
            viewModel.buttonTitleTapped(buttonTitle)
            textField.insertText(buttonTitle)
        }
    }
    
    @objc func didTapDoneButton() {
        textField.resignFirstResponder()
    }
}

