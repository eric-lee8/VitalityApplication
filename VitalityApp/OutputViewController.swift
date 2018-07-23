//
// OutputViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File created and worked on by Jacky Huynh, Eric Joseph Lee, Jordan Cheung, and Philip Choi
// All JSON files created by Philip Choi
// Bugs(fixed): Objects were displayed in the wrong positions

import UIKit

//View controller of the page that displays all the ingreients the user has selected and displays the recipies available

class OutputViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Displays the list of recipies
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var btnCreate: UIButton!
    
    // gets the ingredients from the shared file
    var veg_selected_ingredients = Shared.shared.veg_selected_ingredients
    var meat_selected_ingredients = Shared.shared.meat_selected_ingredients
    var grain_selected_ingredients = Shared.shared.grain_selected_ingredients
    var dairy_selected_ingredients = Shared.shared.dairy_selected_ingredients
 
    var cuisine = Shared.shared.selected_cuisine
    var recipe_URL:String = ""
    var recipe_chosen:String = ""
    var recipe_ingredients = [String]()
    
    var output: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Output View Controller")
        btnCreate.isHidden = true
        
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
        
        for recipe in get_recipes() {
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
        for (key, _) in recipesToOverlapped{
            output.append(key.name)
        }

    }
    
    // JSON file upload
    // goes to json file according the cuisine users have selected, which is assigned to the variable "cuisine"
    func get_recipes() -> [Recipe] {
        if let path = Bundle.main.path(forResource: cuisine, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            print(url)
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
    // function goes through json file and gets the recipe name, and ingredients, and assigns them to variables
    // checks if atleast one ingredient is selected for the create button to appear
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType != UITableViewCellAccessoryType.checkmark)  {
        
            for i in 0...output.count {
                tableView.cellForRow(at: [0,i])?.accessoryType = UITableViewCellAccessoryType.none
            }
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            recipe_chosen = output[indexPath.row]
            
            for recipe in get_recipes() {
                if (recipe_chosen == recipe.name) {
                    for ingredient in recipe.ingredients {
                        recipe_ingredients.append(ingredient.name)
                    }
                    recipe_URL = recipe.url
                }
            }
        }
        
        if ( recipe_chosen.isEmpty != true ) {
            btnCreate.isHidden = false
        }
        
    }
    
    // creates the cells 
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
        recipeViewController.recipe_URL = recipe_URL
    }
    
}

