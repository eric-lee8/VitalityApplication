//
//  OutputViewController.swift
//  VitalityApp
//
//  CMPT276
//Project Group 16
//Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//
// File created and worked on by Jacky Huynh, Eric Joseph Lee, Jordan Cheung, and Philip Choi
//
// Bugs: Recipes did not sort properly, not all recipes showed up, data was not properly sent to viewcontroller so kept crashing, problem erasing check marks on other selected recipes when more than one recipe was selected

import UIKit

//View controller of the page that displays all the ingreients the user has selected and displays the recipies available

class OutputViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Displays the list of ingredients
    @IBOutlet weak var display_ingredients: UITextView!
    
    //Displays the list of recipies
    @IBOutlet weak var tableView: UITableView!
    
    //ingredients to be displayed
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
    var recipe_chosen:String = ""
    var recipe_ingredients = [String]()
    
    var output: [String] = []
    
    var str_veg = String()
    var str_meat = String()
    var str_grain = String()
    var str_dairy = String()
    
    
    //List of ingredients for the recipe that the user has selected has been hardwired for demonstration
    //This feature will be implemented in version 2
    var temp_recipes = [

        ["tofu 1 pound", "broccoli 1 pound", "noodles 1 pound", "pepper 1 pinch"] //sesame noodles with baked tofu
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Output View Controller")

        //testing purposes
        print("vegetables selected", veg_selected_ingredients)
        print("meats selected", meat_selected_ingredients)
        print("grains selected", grain_selected_ingredients)
        print("dairys selected", dairy_selected_ingredients, "\n")
        
        //Display the name of the ingredients on the test box
        
        str_veg = "Vegetable Ingredients:\n "
        str_meat = "\nMeat Ingredients:\n "
        str_grain = "\nGrain Ingredients:\n "
        str_dairy = "\nDairy Ingredients:\n "
        
        if veg_selected_ingredients.isEmpty {
            str_veg += "None\n"
        }
        for veg_ing in veg_selected_ingredients {
            
            str_veg += veg_ing + "\n "
            
        }
        
        if meat_selected_ingredients.isEmpty {
            str_meat += "None\n"
        }
        
        for meat_ing in meat_selected_ingredients {
            
            str_meat += meat_ing + "\n "
            
        }
        
        if grain_selected_ingredients.isEmpty {
            str_grain += "None\n"
        }
        for grain_ing in grain_selected_ingredients {
            
            str_grain += grain_ing + "\n "
            
        }
        
        if dairy_selected_ingredients.isEmpty {
            str_dairy += "None\n"
        }
        for dairy_ing in dairy_selected_ingredients {
            
            str_dairy += dairy_ing + "\n "
            
        }
        
        //display ingredients that user selected in order
        display_ingredients.text =  str_veg + str_grain + str_dairy + str_meat
        
        
        // adding user input to the item array to compare with the ingredients from each recipes in data
        //structure
        
        var items: [String] = []
        
        for veggie in veg_selected_ingredients {
            items.append(veggie)
        }
        
        for grain in grain_selected_ingredients {
            items.append(grain)
        }
        
        for dairy in dairy_selected_ingredients {
            items.append(dairy)
        }
        
        for meat in meat_selected_ingredients {
            items.append(meat)
        }
        
        
        //comparing user selected ingredients with data structure ingredients
        var recipesToOverlapped:[(name: Recipe, value: Int)] = []
        var recipes = get_recipes()
        
        for recipe in recipes {
            var overlapped = 0
            for item in items {
                for ingredient in recipe.ingredients {
                    if item == ingredient.name {
                        overlapped+=1
                    }
                }
            }
            if overlapped > 0 {
                recipesToOverlapped.append((name: recipe, value: overlapped))
            }
        }

        recipesToOverlapped = recipesToOverlapped.sorted(by: {$0.value > $1.value})
        
        
        // adding recipes that matches with the ingredients that user selected from the most to least order
        for (key, value) in recipesToOverlapped{
            output.append(key.name)
        }
        
    }
    
    
    // JSON file upload
    func get_recipes() -> [Recipe] {
        if let path = Bundle.main.path(forResource: "recipes", ofType: "json") {
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView functions that displays the recipes
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //displaying the number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (output.count)
    }
    
    // function that detects if a cell is detected, if a cell is detected put a checkmark, and if another cell is is clicked without a checkmark then put a checkmark on that cell and remove all other checkmarks
    // function also assigning the most recent check marked recipe and its ingredients to variables that will be sent to the next view controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark)  {
            
            for i in 0...output.count {
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.none
            }
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            recipe_chosen = output[indexPath.row]
            recipe_ingredients = temp_recipes[indexPath.row]
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = output[indexPath.row]
        
        return(cell)
    }
    
    // sending data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeViewController = segue.destination as! RecipeViewController
        recipeViewController.recipe = recipe_chosen
        recipeViewController.ingredients = recipe_ingredients
    }
    
}

