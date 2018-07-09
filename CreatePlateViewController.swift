//
//  CreatePlateViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-03.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class CreatePlateViewController: UIViewController {

    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submit(veg_ingredient: [String]) {
        veg_selected_ingredients = veg_ingredient
    }
    
    @IBAction func load(_ sender: Any) {
        print("vegetables selected", veg_selected_ingredients)
        print("meats selected", meat_selected_ingredients)
        print("grains selected", grain_selected_ingredients)
        print("dairys selected", dairy_selected_ingredients, "\n")
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let outputViewController = segue.destination as! OutputViewController
        outputViewController.veg_selected_ingredients = veg_selected_ingredients
        outputViewController.meat_selected_ingredients = meat_selected_ingredients
        outputViewController.grain_selected_ingredients = grain_selected_ingredients
        outputViewController.dairy_selected_ingredients = dairy_selected_ingredients
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
