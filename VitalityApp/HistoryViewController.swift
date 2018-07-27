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
    var recipe_chosen:String = ""
    var recipe_ingredients = [String]()
    
    var cuisine:String = ""
    var recipe_URL:String = ""
    
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
        recipe_chosen = recipes_list[indexPath.row][0]
        cuisine = recipes_list[indexPath.row][1]
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark)  {
            
            for i in 0...recipes_list.count {
                tableView.cellForRow(at: [0, i])?.accessoryType = UITableViewCellAccessoryType.none
            }
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            

        }
        
        if ( recipe_chosen.isEmpty != true ) {
            btnconfirm.isHidden = false
        }
        
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
        recipe_ingredients = [String]()
        for recipe in get_recipes() {
            if (recipe_chosen == recipe.name) {
                for ingredient in recipe.ingredients {
                    recipe_ingredients.append(ingredient.name)
                }
                recipe_URL = recipe.url
            }
        }
    }
    
    func get_recipes() -> [Recipe] {
        if let path = Bundle.main.path(forResource: cuisine, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                return try decoder.decode([Recipe].self, from: data)
            } catch {
                fatalError("Recipe.json cannot be decoded")
            }
        }
        fatalError("Recipe.json does not exist")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyRecipeViewController = segue.destination as! HistoryRecipeViewController
        historyRecipeViewController.recipe = recipe_chosen
        historyRecipeViewController.ingredients = recipe_ingredients
        historyRecipeViewController.recipe_URL = recipe_URL
        historyRecipeViewController.cuisine = cuisine
        
        print(recipe_chosen)
        //print(recipe_ingredients)
    }
}
