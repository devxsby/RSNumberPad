//
//  RSNumberPad.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/06/30.
//

import UIKit
import CryptoKit

@available(iOS 13.0, *)
public final class RSNumberPad: UITextField, PasswordManaging {
    
    private var keyPadActionHandler = KeyPadActionHandler()
    private lazy var keypadViewCreator = KeypadViewCreator(textField: self, actions: self.keyPadActionHandler)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNumberPadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNumberPadView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        configureTapGesture()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        tapGesture.cancelsTouchesInView = false
        superview?.addGestureRecognizer(tapGesture)
    }
    
    private func configureNumberPadView() {
        
        keyPadActionHandler.randomKeyPad.shuffleKeypad()
        inputView = keypadViewCreator.createRandomKeypadView()
        inputAccessoryView = keypadViewCreator.createDoneButtonToolbar()
        updateKeypadView()
        
        delegate = self
        
        addObservers()
    }
    
    func updateKeypadView() {
        guard let keypadView = inputView else {
            return
        }
        
        updateButtonsInView(keypadView)
    }
    
    private func updateButtonsInView(_ view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton,
               let buttonState = keyPadActionHandler.getKeyValue(for: button.tag) {
                button.setTitle(buttonState.title, for: .normal)
            } else {
                updateButtonsInView(subview)
            }
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
}

// MARK: - @objc Function

extension RSNumberPad {
    
    @objc private func didTapDoneButton() {
        resignFirstResponder()
    }
    
    @objc private func didTapOutside() {
        resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if let textFieldFrame = self.superview?.convert(self.frame, to: window) {
            let textFieldBottom = textFieldFrame.origin.y + textFieldFrame.size.height
            
            if textFieldBottom > window.frame.size.height - keyboardHeight {
                let offsetY = textFieldBottom - (window.frame.size.height - keyboardHeight) + 20
                window.frame.origin.y -= offsetY
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        window.frame.origin.y = 0
    }
}

// MARK: - UITextFieldDelegate

@available(iOS 13.0, *)
extension RSNumberPad: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        keyPadActionHandler.randomKeyPad.shuffleKeypad()
        updateKeypadView()
        return true
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        return false
    }
}
