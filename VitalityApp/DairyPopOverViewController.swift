//
//  DairyPopOverViewController.swift
//  VitalityApp
//
//  Created by Eric Joseph Lee on 2018-07-15.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class DairyPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Popupview: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var dairy_ingredients: [String] = ["milk", "cheese", "soybeans", "yogourt", "soymilk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        Popupview.layer.masksToBounds = true
    }
    
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dairy_ingredients.count;
    }
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ( tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark ) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            if ( Shared.shared.dairy_selected_ingredients.contains( dairy_ingredients[indexPath.row] ) ) {
                Shared.shared.dairy_selected_ingredients.remove(at: Shared.shared.dairy_selected_ingredients.index(of: dairy_ingredients[indexPath.row])! )
            }
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            Shared.shared.dairy_selected_ingredients.append(dairy_ingredients[indexPath.row ])
        }
        
        print("dairy Name : " + dairy_ingredients[indexPath.row])
        
    }
    
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dairy_ingredients[indexPath.row]
        if ( Shared.shared.dairy_selected_ingredients.contains((cell.textLabel?.text)!)) {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        return cell
    }
    
    
    // Close PopUp
    @IBAction func closePopup(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}

