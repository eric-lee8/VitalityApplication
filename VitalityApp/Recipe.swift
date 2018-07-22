//  Recipe.swift
//  VitalityApp
//
//  CMPT276
// Project Group 16
// Team Vitality
// Members: Eric Joseph Lee, Phillip Choi, Jacky Huynh, Jordan Cheung
//
// File created and worked on by Philip Choi

import Foundation

struct Recipe : Decodable {
    
    let name : String
    let url : String
    let ingredients : [Ingredient]
    
    init(name : String, url: String, ingredients : [Ingredient]) {
        self.name = name
        self.url = url
        self.ingredients = ingredients
    }
    
    public var description: String { return name }
}
