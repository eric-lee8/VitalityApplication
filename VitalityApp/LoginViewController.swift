//
//  LoginViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-26.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userInput: UITextField!
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        UserDefaults.standard.set(userInput.text, forKey: "username")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
