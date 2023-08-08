//
//  ViewController.swift
//  RSNumberPad
//
//  Created by devxsby on 07/02/2023.
//  Copyright (c) 2023 devxsby. All rights reserved.
//

import UIKit

import RSNumberPad // Import the RSNumberPad library

final class ViewController: UIViewController {
    
    // Connect this IBOutlet to the RSNumberPad instance in the storyboard
    @IBOutlet private weak var numberPadTextField: RSNumberPad!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction private func saveButtonDidTap(_ sender: Any) {
        // Check if a password is entered
        guard let password = numberPadTextField.text, !password.isEmpty else {
            showAlert(withTitle: "Error", message: "No password entered.")
            return
        }
        
        // Save the password using the RSNumberPad savePassword method
        numberPadTextField.savePassword(key: "password", password: password)
        
        showAlert(withTitle: "Success", message: "Password has been saved.")
    }
    
    @IBAction private func checkButtonDidTap(_ sender: Any) {
        // Check if a password is entered
        guard let password = numberPadTextField.text, !password.isEmpty else {
            showAlert(withTitle: "Error", message: "No password entered.")
            return
        }
        // Check if the entered password matches the saved password using the RSNumberPad checkPassword method
        if numberPadTextField.checkPassword(key: "password", password: password) {
            showAlert(withTitle: "Success", message: "Input matches the saved password.")
        } else {
            showAlert(withTitle: "Error", message: "Input doesn't match the saved password.")
        }
    }
}

extension ViewController {
    
    // MARK: - Helper Methods
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
