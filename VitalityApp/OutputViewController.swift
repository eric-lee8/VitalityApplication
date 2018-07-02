//
//  OutputViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-02.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {

    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Final selected ingredients")
        print(veg_selected_ingredients)
        print(meat_selected_ingredients)
        print(grain_selected_ingredients)
        print(dairy_selected_ingredients)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
