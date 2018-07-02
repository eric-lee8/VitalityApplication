//
//  EthnicityViewController.swift
//  VitalityApp
//
//  Created by Eric Joseph Lee on 2018-07-01.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class EthnicityViewController: UIViewController {
    
    @IBOutlet weak var btnSelect: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        
        let cn : String = Shared.shared.ethnicityName ?? "......."
        btnSelect.setTitle(cn,for: .normal)
        
    }
    
}


