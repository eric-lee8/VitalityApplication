//  Ingredient.swift
//  VitalityApp
//
//  CMPT276
//Project Group 16
//Team Vitality
// Members: Eric Joseph Lee, Phillip Choi, Jacky Huynh, Jordan Cheung
//
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//
// File created and worked on by Philip Choi


import Foundation

class Ingredient : Decodable {
    let name: String
    let amount: String
    let measure: String
    
    init(name : String, amount: String, measure: String) {
        self.name = name
        self.amount = amount
        self.measure = measure
    }
    
    public var description: String { return amount + measure + name }
}
