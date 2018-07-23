//
//  Shared.swift
//  VitalityApp
//
//  Created by Eric Joseph Lee on 2018-07-01.

import Foundation

final class Shared {
    static let shared = Shared()
    
    // variables that all view controllers can access
    var recipe_database = [[String]]()
    var selected_cuisine:String!
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
}

