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
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var logoutBtnLabel: UIButton!
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "username")
        loginBtn.setTitle("Login", for: .normal)
        logoutBtnLabel.isHidden = true
    }
    
    @IBAction func historyBtn(_ sender: Any) {
        
        let reachability = Reachability.init()
        
        if (reachability?.connection == .none) {
            createAlert(title: "Internet Connect Required For History", message: "Please Connect to Wifi")
        }
        else if (UserDefaults.standard.object(forKey: "username") == nil ) {
            createAlert(title: "Login is Required", message: "Please Login")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.object(forKey: "username") != nil) {
            databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
                let database_recipe = snapshot.value as? [String]
                let data = database_recipe
                if (!Shared.shared.recipe_database.contains(data!)) {
                            Shared.shared.recipe_database.append(data!)
                }
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let user = UserDefaults.standard.object(forKey: "username") as? String {
            logoutBtnLabel.isHidden = false
            logoutBtnLabel.setTitle("Logout", for: .normal)
            loginBtn.setTitle(user, for: .normal)
        }
        else {
            logoutBtnLabel.isHidden = true
            loginBtn.setTitle("Login", for: .normal)
        }
 
        Shared.shared.selected_cuisine = "---------"
        Shared.shared.veg_selected_ingredients = [String]()
        Shared.shared.meat_selected_ingredients = [String]()
        Shared.shared.grain_selected_ingredients = [String]()
        Shared.shared.dairy_selected_ingredients = [String]()
        Shared.shared.recipe_database = [[String]]()
        
        if (UserDefaults.standard.object(forKey: "username") != nil) {
            databaseHandle = Database.database().reference().child((UserDefaults.standard.object(forKey: "username") as? String)!).observe(.childAdded, with: { (snapshot) in
                let database_recipe = snapshot.value as? [String]
                let data = database_recipe
                
                if (!Shared.shared.recipe_database.contains(data!)) {
                    Shared.shared.recipe_database.append(data!)
                }
                
            })
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
