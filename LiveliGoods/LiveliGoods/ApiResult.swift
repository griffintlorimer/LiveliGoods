//
//  ApiResult.swift
//  LiveliGoods
//
//  Created by Griffin Lorimer on 11/11/22.
//

import Foundation

//struct ApiResult:Decodable {
//    let recipesUsed: Int
//    let calories: DescItem
//    let fat: DescItem
//    let protein: DescItem
//    let carbs: DescItem
//}
//
//struct ConfidenceRange95Percent: Decodable {
//    let min: Float
//    let max: Float
//}
//
//struct DescItem: Decodable{
//    let value: Float
//    let unit: String
//    let confidenceRange95Percent: ConfidenceRange95Percent
//    let standardDeviation: Float
//}




struct ApiResult:Decodable {
    let uri: String?
    let calories: Double
    let totalWeight: Double?
    let dietLabels: [String]?
    let healthLabels: [String]?
    let cautions: [String]?
    let totalNutrients: TotalNutrients
}

struct TotalNutrients:Decodable{
    let FAT: Nutrient?
    let CHOCDF: Nutrient?
    let PROCNT: Nutrient?
}


struct Nutrient:Decodable {
    let label: String
    let quantity: Double
    let unit: String
    
}
