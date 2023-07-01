//
//  ViewController.swift
//  RSNumberPad
//
//  Created by 80062632 on 07/02/2023.
//  Copyright (c) 2023 80062632. All rights reserved.
//

import UIKit
import RSNumberPad

class ViewController: UIViewController {
    
    @IBOutlet private weak var numberPadTextField: RSNumberPad!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func saveButtonDidTap(_ sender: Any) {
        guard let password = numberPadTextField.text, !password.isEmpty else {
            showAlert(withTitle: "Error", message: "No password entered.")
            return
        }
        numberPadTextField.savePassword(key: "password", password: password)
        showAlert(withTitle: "Success", message: "Password has been saved.")
    }
    
    @IBAction private func checkButtonDidTap(_ sender: Any) {
        guard let password = numberPadTextField.text, !password.isEmpty else {
            showAlert(withTitle: "Error", message: "No password entered.")
            return
        }
        if numberPadTextField.checkPassword(key: "password", password: password) {
            showAlert(withTitle: "Success", message: "Input matches the saved password.")
        } else {
            showAlert(withTitle: "Error", message: "Input doesn't match the saved password.")
        }
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
