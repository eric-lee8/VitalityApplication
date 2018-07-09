//
//  GrainTableViewController.swift
//  VitalityApp
//
//  CMPT276
//Project Group 16
//Team Vitality
// Members: Eric Joseph Lee, Phillip Choi, Jacky Huynh, Jordan Cheung
//
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//
// File created and worked on by Jacky Huynh
// Bugs: Sometimes when selecting certain ingredients other ingredients that were not selected were selected, or all of them would be selected, out of index errors were common when selected ingredients, not all ingredients showed up, some selected ingredients were not checked marked,
// Changes: Decided to separate the selection of each ingredient food into 4 different view controllers, and the changed the cells so they don't drop down when you click on them, as a result the bugs above were fixed.


import UIKit

//Table View Controller to select all the grains

class GrainTableViewController: UITableViewController {
    var temp_grain_ingredients = ["noodles", "rice", "brown rice", "bread", "vermicelli", "quinoa"]
    
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()

    // displaying the number of rows in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return temp_grain_ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = temp_grain_ingredients[indexPath.row]
        return cell
    }
    
    // function that detects when each cell in the table is clicked on
    // if a cell is clicked add or checkmark, or remove
    // as well as appending a removing ingredients to selected arrays based on the checkmarks
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark ) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            if ( grain_selected_ingredients.contains( temp_grain_ingredients[indexPath.row ] ) ) {
                grain_selected_ingredients.remove(at: grain_selected_ingredients.index(of: temp_grain_ingredients[indexPath.row ])! )
            }
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            grain_selected_ingredients.append(temp_grain_ingredients[indexPath.row])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Grain View Controller")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // sending data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dairyViewController = segue.destination as! DairyTableViewController
        dairyViewController.veg_selected_ingredients = veg_selected_ingredients
        dairyViewController.meat_selected_ingredients = meat_selected_ingredients
        dairyViewController.grain_selected_ingredients = grain_selected_ingredients
    }
}
