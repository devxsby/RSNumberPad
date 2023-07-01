//
//  RSNumberPad.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/06/30.
//

import UIKit

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
