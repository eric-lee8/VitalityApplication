//
//  VegetableTableViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-03.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class VegetableTableViewController: UITableViewController {

    var temp_veg_ingredients = ["broccoli", "ginger", "garlic", "pepper", "peanuts", "cucumber", "cilantro", "lettuce", "mung bean", "scallions", "carrot"]
    var veg_selected_ingredients = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return temp_veg_ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark ) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            if ( veg_selected_ingredients.contains(temp_veg_ingredients[indexPath.row - 1]) ) {
                veg_selected_ingredients.remove(at: veg_selected_ingredients.index(of: temp_veg_ingredients[indexPath.row - 1])! )
            }
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
}
