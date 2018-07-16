//
//  SelectionViewController.swift
//  VitalityApp
//
//  Created by Eric Joseph Lee on 2018-07-10.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    @IBOutlet weak var btnSelect: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
        
        print("Veg:")
        print(Shared.shared.veg_selected_ingredients)
        print("Meat:")
        print(Shared.shared.meat_selected_ingredients)
        print("Grain:")
        print(Shared.shared.grain_selected_ingredients)
        print("Dairy:")
        print(Shared.shared.dairy_selected_ingredients)
    }
    
}

