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
            print("hello")
            databaseHandle = Database.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
            let database_recipe = snapshot.value as? [String]
            let data = database_recipe
                
            if (!Shared.shared.recipe_database.contains(data!)) {
                    Shared.shared.recipe_database.append(data!)
            }
        })
 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Shared.shared.selected_cuisine = "---------"
        Shared.shared.veg_selected_ingredients = [String]()
        Shared.shared.meat_selected_ingredients = [String]()
        Shared.shared.grain_selected_ingredients = [String]()
        Shared.shared.dairy_selected_ingredients = [String]()
        
        databaseHandle = Database.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
            let database_recipe = snapshot.value as? [String]
            let data = database_recipe
            
            if (!Shared.shared.recipe_database.contains(data!)) {
                Shared.shared.recipe_database.append(data!)
            }
            
        })
    }
}
