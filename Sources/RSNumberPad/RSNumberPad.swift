//
//  RSNumberPad.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/06/30.
//

import UIKit
import CryptoKit

public class RSNumberPad: UITextField {
    
    private var viewModel = KeyPadViewModel()
    private lazy var keypadViewCreator = KeypadViewCreator(textField: self,
                                                           viewModel: self.viewModel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNumberPadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNumberPadView()
    }
    
    private func configureNumberPadView() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapOutside))
        superview?.addGestureRecognizer(tapGesture)
        
        viewModel.randomKeyPad.shuffleKeypad()
        inputView = keypadViewCreator.createRandomKeypadView()
        inputAccessoryView = keypadViewCreator.createDoneButtonToolbar()
        updateKeypadView()
        
        delegate = self
    }
    
    @objc private func didTapDoneButton() {
        resignFirstResponder()
    }
    
    @objc private func didTapOutside() {
        resignFirstResponder()
    }
    
    func updateKeypadView() {
        guard let keypadView = inputView else {
            return
        }
        
        for case let button as UIButton in keypadView.subviews {
            guard let buttonState = viewModel.getValue(for: button.tag) else {
                continue
            }
            button.setTitle(buttonState.title, for: .normal)
        }
    }
    
    public func savePassword(key: String, password: String) {
        let hashedPassword = generateHash(from: password)
        _ = KeychainManager.save(key: key, data: hashedPassword)
    }
    
    public func checkPassword(key: String, password: String) -> Bool {
        let hashedPassword = generateHash(from: password)
        let savedPassword = KeychainManager.load(key: key)
        
        return hashedPassword == savedPassword
    }
    
    private func generateHash(from string: String) -> String {
        let inputData = Data(string.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashedString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        return hashedString
    }
}

extension RSNumberPad: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewModel.randomKeyPad.shuffleKeypad()
        updateKeypadView()
        return true
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        return false
    }
}
