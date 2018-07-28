//
//  Shared.swift
//  VitalityApp
//
//  Created by Eric Joseph Lee on 2018-07-01.

import Foundation

final class Shared {
    static let shared = Shared()
    
    var recipe_chosen:String!
    var recipe_ingredients = [String]()
    var recipe_URL:String!
    
    // variables that all view controllers can access
    var recipe_database = [[String]]()
    var veg_weight_total : Double = 0
    var grain_weight_total : Double = 0
    var meat_weight_total : Double = 0
    
    var selected_cuisine:String!
    var veg_selected_ingredients = [String]()
    var meat_selected_ingredients = [String]()
    var grain_selected_ingredients = [String]()
    var dairy_selected_ingredients = [String]()
    
}

