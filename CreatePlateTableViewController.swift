//
//  ViewController.swift
//  vitality
//
//  Created by Jacky Huynh on 2018-06-29.
//  Copyright © 2018 ProjectGroup16. All rights reserved.
//

import UIKit

//Struct for each cell
struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class TableViewController: UITableViewController {
    
    //creating an array of cells
    var tableViewData = [cellData]()
    
    //these are place holder ingredients
    //can fill these arrays up with ingredients or connect to databse
    var temp_veg_ingredients = ["veg1", "veg2", "veg3"]
    var temp_meat_ingredients = ["meat1", "meat2", "meat3"]
    var temp_grain_ingredients = ["grain1", "grain2", "grain3"]
    var temp_dairy_ingredients = ["dairy1", "dairy2", "dairy3"]
    
    //these arrays contain what users have chosen as their ingredients, each food group having their own array
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewData = [cellData(opened: false, title: "Vegetables", sectionData: temp_veg_ingredients),
                         cellData(opened: false, title: "Meat", sectionData: temp_meat_ingredients),
                         cellData(opened: false, title: "Grain", sectionData: temp_grain_ingredients),
                         cellData(opened: false, title: "Dairy", sectionData: temp_dairy_ingredients)
        ]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // for displaying the number of sections (number of cells)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    // for displaying the number of rows when menu drop downs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                else {
                    return UITableViewCell()
            }
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                else {
                    return UITableViewCell()
            }
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    //whenever a cell is selected this function is called
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // if the cell has a checkmark, and users press the cell with the checkmark the checkmark disappears, and the ingredient that was picked is removed from the selected_ingredients arrays
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none //removes the checkmark
            
            if (tableViewData[indexPath.section].title == "Vegetables") { //if selected cell is vegetable remove the ingredient from veg_selected_ingredients
                if ( veg_selected_ingredients.contains( temp_veg_ingredients[indexPath.row - 1] ) ) {
                    veg_selected_ingredients.remove(at: veg_selected_ingredients.index(of: temp_veg_ingredients[indexPath.row - 1])! )
                }
            }
            else if (tableViewData[indexPath.section].title == "Meat") {//if selected cell is meat remove the ingredient from meat_selected_ingredients
                if ( meat_selected_ingredients.contains( temp_meat_ingredients[indexPath.row - 1] ) ) {
                    meat_selected_ingredients.remove(at: meat_selected_ingredients.index(of: temp_meat_ingredients[indexPath.row - 1])! )
                }
            }
            else if (tableViewData[indexPath.section].title == "Grain") { //if selected cell is grain remove the ingredient from grain_selected_ingredients
                if ( grain_selected_ingredients.contains( temp_grain_ingredients[indexPath.row - 1] ) ) {
                    grain_selected_ingredients.remove(at: grain_selected_ingredients.index(of: temp_grain_ingredients[indexPath.row - 1])! )
                }
            }
            else if (tableViewData[indexPath.section].title == "Dairy") { //if selected cell is dairy remove the ingredient from dairy_selected_ingredients
                if ( dairy_selected_ingredients.contains( temp_dairy_ingredients[indexPath.row - 1] ) ) {
                    dairy_selected_ingredients.remove(at: dairy_selected_ingredients.index(of: temp_dairy_ingredients[indexPath.row - 1])! )
                }
            }
        }
            
            //if cell is not the main cell, then put a checkmark
        else if (indexPath.row != 0 ) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            //if ingredient selected is a vegetable add to ingredient array
            if (tableViewData[indexPath.section].title == "Vegetables") {
                veg_selected_ingredients.append(temp_veg_ingredients[indexPath.row - 1])
            }
                
                //if ingredient selected is a vegetable add to ingredient array
            else if (tableViewData[indexPath.section].title == "Meat") {
                meat_selected_ingredients.append(temp_meat_ingredients[indexPath.row - 1])
            }
                
                //if ingredient selected is a vegetable add to ingredient array
            else if (tableViewData[indexPath.section].title == "Grain") {
                grain_selected_ingredients.append(temp_grain_ingredients[indexPath.row - 1])
            }
                
                //if ingredient selected is a vegetable add to ingredient array
            else if (tableViewData[indexPath.section].title == "Dairy") {
                dairy_selected_ingredients.append(temp_dairy_ingredients[indexPath.row - 1])
            }
            
        }
        
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else {
                
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
        // printing out the ingredient_selected arrays everytime a cell is selected, used this for debugging purposes
        print("vegetables selected", veg_selected_ingredients)
        print("meats selected", meat_selected_ingredients)
        print("grains selected", grain_selected_ingredients)
        print("dairys selected", dairy_selected_ingredients, "\n")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var outputViewController = segue.destination as! OutputViewController
        outputViewController.veg_selected_ingredients = veg_selected_ingredients
        outputViewController.meat_selected_ingredients = meat_selected_ingredients
        outputViewController.grain_selected_ingredients = grain_selected_ingredients
        outputViewController.dairy_selected_ingredients = dairy_selected_ingredients
    }
}
