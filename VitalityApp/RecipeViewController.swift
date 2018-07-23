//
// RecipeViewController.swift
// VitalityApp
//
// CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Philip Choi, Jacky Huynh, Jordan Cheung
//
// File Created by Eric Lee, and worked on by Jacky Huynh, Eric Lee, and Jordan Cheung
//
// Bugs(fixed): Recipe name was not showing up properly, recipe name was cut off when displayed, URL link was not working 
//
// Added: URL link to name of the recipe

import UIKit
import FirebaseDatabase

//The view controller of the page that displays your selected Heathy Plate with all of its details
class RecipeViewController: UIViewController {

    // recipe button, and text view objects
    @IBOutlet weak var recipe_button: UIButton!
    @IBOutlet weak var ingredients_list: UITextView!
    @IBOutlet var btnSave: UIButton!
    
    // opens safari with link if button is clicked
    @IBAction func recipe_URL(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipe_URL)!)
    }
    
    // recipe name, ingredients, and URL link
    var recipe:String = ""
    var ingredients = [String]()
    var recipe_URL:String = ""
    let rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Recipe View Controller")

        //For testing purposes
        print("Final")
        print("Recipe", recipe)
        print("ingredients", ingredients)
        
        
        
        // sets the button title
        recipe_button.setTitle(recipe, for: .normal)
        
        var str_ingredients = String()
        str_ingredients = "List of Ingredients : \n"
        
        
        for ingredient in ingredients {
            str_ingredients += ingredient + "\n"
        }
        
        //Display the list of ingredients
        ingredients_list.text = str_ingredients
    }
    
    @IBAction func btnSave(_ sender: Any) {
        btnSave.isHidden = true
        rootRef.child("user").childByAutoId().setValue([recipe, Shared.shared.selected_cuisine])

    }
}
