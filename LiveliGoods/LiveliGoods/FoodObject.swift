//
//  FoodObject.swift
//  LiveliGoods
//
//  Created by Griffin Lorimer on 11/11/22.
//

import Foundation

struct FoodObject:Decodable {
    let name: String?
    let type: String?
    let totalResults: Int?
    let totalResultsVariants: Int?
    let results: [Result?]
}


struct Result:Decodable {
    let id: Int?
    let name: String?
    let image: String?
    let link: String?
    let type: String?
    let relevance: Float?
    let content: String?
    let dataPoints: [String?]?
}
