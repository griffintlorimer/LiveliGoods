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
        var stringUrl = "https://api.edamam.com/api/nutrition-data?app_id=eb6e9a84&app_key=1da48038e8aec15e768e92948e85aba7&nutrition-type=logging&ingr=1 \(searchTerm)"
        stringUrl = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if (searchTerm != ""){
        let url = URL(string: stringUrl)
            print(url)
        let data = try! Data(contentsOf: url!)
            print(data.base64EncodedString())
        
        let json = String(data: data, encoding: String.Encoding.utf8)
        
        var theData: ApiResult
        theData = try! JSONDecoder().decode(ApiResult.self, from:data)
            
        
        print(theData.totalNutrients.CHOCDF?.quantity)
        print(theData.totalNutrients.FAT?.quantity)
        print(theData.totalNutrients.PROCNT?.quantity)


        return theData
        
        } else {
            return nil
        }
        
    }
}
