//
//  Food.swift
//  project1_Blue
//
//  Created by Sproull Student on 11/11/22.
//

import Foundation
import UIKit

struct ImageAPIResult:Decodable {
    let is_food: Bool
    let results: [Items]
}

struct Items:Decodable {
    let items: [Item]
}

struct Item:Decodable {
    let name: String
    let nutrition: Nutrition
}

struct Nutrition:Decodable {
    //let totalCarbs: Double
    //let totalFat: Double
    //let protein: Double
    let calories: Double
}

struct Water: Decodable{
    var time: String!
    var amount: String!
    
}

struct WaterList: Decodable {
    var waterList: [Water]
}
