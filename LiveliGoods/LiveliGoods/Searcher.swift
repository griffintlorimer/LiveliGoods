//
//  Searcher.swift
//  LiveliGoods
//
//  Created by Griffin Lorimer on 11/10/22.
//

import Foundation


import Foundation

class Searcher {
    func getFoods(searchTerm: String) -> ApiResult? {
        print("GET FOODS CALLED")
        let apiKey = "7c81998fe17a4ece8f5ac244c43155fc"
        var stringUrl = "https://api.spoonacular.com/recipes/guessNutrition?apiKey=\(apiKey)&title=\(searchTerm)"
        stringUrl = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if (searchTerm != ""){
        let url = URL(string: stringUrl)
        let data = try! Data(contentsOf: url!)
        
        let json = String(data: data, encoding: String.Encoding.utf8)
        
        var theData: ApiResult
        theData = try! JSONDecoder().decode(ApiResult.self, from:data)
        return theData
        
        } else {
            return nil
        }
        
    }
}
