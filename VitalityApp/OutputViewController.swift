//
//  OutputViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-02.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit
import CoreData

class OutputViewController: UIViewController {

    //ingredients to be displayed
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    //var output: [String] = []
    var percentages: [Float] = []
    var count:Float = 0
    
    var temp_recipes = [
        ["pork", "garlic", "ginger"],//spicy pork & green bean stir-fry
        ["broccoli", "pepper", "peanuts"], //kung pao broccoli
        ["tofu", "cucumber", "cilantro", "peanuts"],//tofu cocumber salad
        ["mung bean", "scallions", "lettuce", "carrot"], //moo shu vegetables
        ["tofu", "broccoli", "noodles", "pepper"] //sesame noodles with baked tofu
    ]
    
    //recipes to be displayed
    var output = ["spicy pork & green bean stir-fry", "kung pao broccoli", "tofu cucumber salad", "moo shu vegetables",                    "sesame noodles with baked tofu"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        /*
         let newUser = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context)
         
         newUser.setValue("veg5 recipe", forKey: "name")
         newUser.setValue("veg5", forKey: "ingredients")
         
         do{
         try context.save()
         print("HELLO")
         }
         catch{
         
         }
         
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
         request.returnsObjectsAsFaults = false
         do{
         let recipes = try context.fetch(request)
         
         if recipes.count>0{
         for recipes in recipes as! [NSManagedObject] {
         count = 0
         if let ingredients = recipes.value(forKey: "ingredients") as? String {
         */
        for j in temp_recipes {
            count = 0
            let ingredients = j
            for i in veg_selected_ingredients {
                if ( ingredients.contains(i) ) {
                    count = count + 1
                }
            }
            for i in meat_selected_ingredients {
                if ( ingredients.contains(i) ) {
                    count = count + 1
                }
            }
            for i in grain_selected_ingredients {
                if ( ingredients.contains(i) ) {
                    count = count + 1
                }
            }
            for i in dairy_selected_ingredients {
                if ( ingredients.contains(i) ) {
                    count = count + 1
                }
            }
            percentages.append( (count/Float(ingredients.count)) )
            /*
             if let name = temp_recipes.value(forKey: "name") as? String{
             output.append(name)
             }
             */
        }
        /*
         }
         }
         }
         catch{
         }
         */
        
        //sort
        for x in 0 ..< percentages.count - 1 {
            
            var highest = x
            for y in x + 1 ..< percentages.count {
                if percentages[y] > percentages[highest] {
                    highest = y
            
            }
            
            if x != highest {
                percentages.swapAt(x, highest)
                output.swapAt(x, highest)
            }
        }
        print(percentages)
        print("Suggested Recipes", output)
        
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
}
