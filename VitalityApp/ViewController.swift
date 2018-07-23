//
// ViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File created by Eric Joseph Lee, Jacky Huynh


import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        databaseHandle = Database.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
            let database_recipe = snapshot.value as? [String]
            if let data = database_recipe {
                Shared.shared.recipe_database.append(data)
            }
        })
        
    }
}

