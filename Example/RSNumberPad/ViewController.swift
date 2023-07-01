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
        guard let password = numberPadTextField.text else {
            print("No password entered.")
            return
        }
        numberPadTextField.savePassword(key: "password", password: password)
        print("Password has been saved.")
    }
    
    @IBAction private func checkButtonDidTap(_ sender: Any) {
        
        guard let password = numberPadTextField.text else {
            print("No password entered.")
            return
        }
        if numberPadTextField.checkPassword(key: "password", password: password) {
            print("Input matches the saved password.")
        } else {
            print("Input doesn't match the saved password.")
        }
    }
}

