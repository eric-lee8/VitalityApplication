//
//  HistoryViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-23.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
    @IBOutlet var btnconfirm: UIButton!
    var recipes_list = Shared.shared.recipe_database
    
    /*
    var recipe_chosen:String = ""
    var recipe_ingredients = [String]()
    var cuisine:String = ""
    var recipe_URL:String = ""
    */
    
    override func viewDidLoad() {
        btnconfirm.isHidden = true
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipes_list[indexPath.row][0]
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Shared.shared.recipe_chosen = recipes_list[indexPath.row][0]
        Shared.shared.selected_cuisine = recipes_list[indexPath.row][1]
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark)  {
            
            for i in 0...recipes_list.count {
                tableView.cellForRow(at: [0, i])?.accessoryType = UITableViewCellAccessoryType.none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        if ( Shared.shared.recipe_chosen.isEmpty != true ) {
            btnconfirm.isHidden = false
        }
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
        Shared.shared.recipe_ingredients = [String]()
        for recipe in get_recipes(cuisine: Shared.shared.selected_cuisine) {
            if (Shared.shared.recipe_chosen == recipe.name) {
                for ingredient in recipe.ingredients {
                    Shared.shared.recipe_ingredients.append(ingredient.name)
                }
                Shared.shared.recipe_URL = recipe.url
            }
        }
    }
    
    
    @IBAction func analyzeBtn(_ sender: Any) {
        let cuisines = ["Chinese"]
        for cuisine in cuisines {
            for recipe in get_recipes(cuisine: cuisine) {
                for database_recipe in Shared.shared.recipe_database {
                    if (database_recipe[0] == recipe.name) {
                        Shared.shared.veg_weight_total = Shared.shared.veg_weight_total + Double(recipe.Veggie_Weight)!
                        Shared.shared.grain_weight_total = Shared.shared.grain_weight_total + Double(recipe.Grain_Weight)!
                        Shared.shared.meat_weight_total = Shared.shared.meat_weight_total + Double(recipe.Meat_Weight)!
                    }
                }
            }
        }
    }
    
    func get_recipes(cuisine:String) -> [Recipe] {
        if let path = Bundle.main.path(forResource: cuisine, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                return try decoder.decode([Recipe].self, from: data)
            }
            catch {
                fatalError("Recipe.json cannot be decoded")
            }
        }
        fatalError("Recipe.json does not exist")
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyRecipeViewController = segue.destination as! HistoryRecipeViewController
        historyRecipeViewController.recipe = recipe_chosen
        historyRecipeViewController.ingredients = recipe_ingredients
        historyRecipeViewController.recipe_URL = recipe_URL
        historyRecipeViewController.cuisine = cuisine

    }
 */
}
