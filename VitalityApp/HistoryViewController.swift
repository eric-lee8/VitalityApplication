//
//  HistoryViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-21.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

    var recipes_list = Shared.shared.recipe_database
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes_list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipes_list[indexPath.row][0]
        return cell
    }
    

}
