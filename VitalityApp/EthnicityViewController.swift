//
//  EthnicityViewController.swift
//  VitalityApp
//
//  Created by Eric Joseph Lee on 2018-07-13.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class EthnicityViewController: UIViewController {
    
    @IBOutlet weak var btnSelect: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
        
        let cn : String = Shared.shared.selected_cuisine ?? "---------"
        btnSelect.setTitle(cn,for: .normal)
        
    }
    
}
