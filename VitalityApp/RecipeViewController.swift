//
//  RecipeViewController.swift
//  VitalityApp
//
//  CMPT276
//Project Group 16
//Team Vitality
// Members: Eric Joseph Lee, Phillip Choi, Jacky Huynh, Jordan Cheung
//
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//
// File created by Jacky Huynh, and worked on by Eric Joseph Lee
//
// Bugs: Recipe name was not showing up properly, recipe name was cut off when displayed
import UIKit

//The view controller of the page that displays your selected Heathy Plate with all of its details

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipe_name: UILabel! //Displays the name of the Plate
    
    @IBOutlet weak var ingredients_list: UITextView! //Displays the list of ingredients
    
    var recipe:String = ""
    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Recipe View Controller")

        //For testing purposes
        print("Final")
        print("Recipe", recipe)
        print("ingredients", ingredients)
        
        recipe_name.text = recipe
        
        var str_ingredients = String()
        
        str_ingredients = "List of Ingredients : \n"
        
        
        for ingredient in ingredients {
            str_ingredients += ingredient + "\n"
        }
        
        //Display the list of ingredients
        ingredients_list.text = str_ingredients
        
    }

}
