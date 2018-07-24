//
//  HistoryRecipeViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-23.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class HistoryRecipeViewController: UIViewController {
    
    @IBOutlet var btnURLlabel: UIButton!
    @IBOutlet var ingredients_list: UITextView!
    
    var recipe:String = ""
    var ingredients = [String]()
    var recipe_URL:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(recipe)
        print(ingredients)
        
        // sets the button title
        btnURLlabel.setTitle(recipe, for: .normal)
        var str_ingredients = String()
        
        for ingredient in ingredients {
            str_ingredients += ingredient + "\n"
        }
        
        //Display the list of ingredients
        ingredients_list.text = str_ingredients
    }
    
    
    @IBAction func btnURL(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipe_URL)!)
    }
    
    
    @IBAction func btnHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

