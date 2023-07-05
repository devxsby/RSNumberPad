//
//  RSNumberPad.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/06/30.
//

import UIKit
import CryptoKit

@available(iOS 13.0, *)
public final class RSNumberPad: UITextField {
    
    private var keyPadActionHandler = KeyPadActionHandler()
    private lazy var keypadViewCreator = KeypadViewCreator(textField: self, actions: self.keyPadActionHandler)
    
    private var originalFrame: CGRect?
    private var isKeyboardShown = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNumberPadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNumberPadView()
    }
    
    private func configureNumberPadView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        superview?.addGestureRecognizer(tapGesture)
        
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
        
        for case let button as UIButton in keypadView.subviews {
            guard let buttonState = keyPadActionHandler.getKeyValue(for: button.tag) else {
                continue
            }
            button.setTitle(buttonState.title, for: .normal)
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

// MARK: - Password Storage, Password Verification

extension RSNumberPad {
    
    public func savePassword(key: String, password: String) {
        let hashedPassword = generateHash(from: password)
        let result = KeychainManager.save(key: key, data: hashedPassword)
        
        switch result {
        case .success():
            debugPrint("Password saved successfully.")
        case .failure(let error):
            debugPrint("Failed to save password: \(error.localizedDescription)")
        }
    }
    
    public func checkPassword(key: String, password: String) -> Bool {
        let hashedPassword = generateHash(from: password)
        let result = KeychainManager.load(key: key)
        
        switch result {
        case .success(let savedPassword):
            return hashedPassword == savedPassword
        case .failure(let error):
            debugPrint("Failed to load password: \(error.localizedDescription)")
            return false
        }
    }
    
    private func generateHash(from string: String) -> String {
        let inputData = Data(string.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashedString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        return hashedString
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
