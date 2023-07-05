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
    
    private var keyboardHeight: CGFloat = 0
    private var originalWindowFrame: CGRect = UIScreen.main.bounds
    private var keyPadActionHandler = KeyPadActionHandler()
    private lazy var keypadViewCreator = KeypadViewCreator(textField: self, actions: self.keyPadActionHandler)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNumberPadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNumberPadView()
        addObservers()
    }
    
    private func configureNumberPadView() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapOutside))
        superview?.addGestureRecognizer(tapGesture)
        
        keyPadActionHandler.randomKeyPad.shuffleKeypad()
        inputView = keypadViewCreator.createRandomKeypadView()
        inputAccessoryView = keypadViewCreator.createDoneButtonToolbar()
        updateKeypadView()
        
        delegate = self
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    @objc private func didTapDoneButton() {
        resignFirstResponder()
    }
    
    @objc private func didTapOutside() {
        resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                keyboardHeight = keyboardSize.height
            }
        }
        
        let textFieldBottomPosition = convert(frame, to: nil).maxY
        let screenHieght = UIScreen.main.bounds.height
        
        if screenHieght - textFieldBottomPosition < keyboardHeight {
            let shiftAmount = self.keyboardHeight - (screenHieght - textFieldBottomPosition) + 20
            if let window = UIApplication.shared.windows.first {
                originalWindowFrame = window.frame
                UIView.animate(withDuration: 0.25) {
                    window.frame = window.frame.offsetBy(dx: 0, dy: -shiftAmount)
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if let window = UIApplication.shared.windows.first {
            UIView.animate(withDuration: 0.25) {
                window.frame = self.originalWindowFrame
            }
        }
    }
    
    @objc private func orientationChanged(_ notification: Notification) {
        if self.isFirstResponder {
            self.resignFirstResponder()
            self.becomeFirstResponder()
        }
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
