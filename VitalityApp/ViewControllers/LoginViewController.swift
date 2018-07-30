//
//  LoginViewController.swift
//  VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Created by Jacky Huynh on 2018-07-26.


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // UserInput text field object
    @IBOutlet var userInput: UITextField!
    
    // cancel button, dismisses viewcontroller
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // confirm button, saves username entered
    @IBAction func confirmBtn(_ sender: Any) {
        UserDefaults.standard.set(userInput.text, forKey: "username")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // if keyboard is up and users touches outside the keyboard, then keyboard is dimissed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
