//
//  RapidAPI.swift
//  Reci-Pie
//
//  Created by Vi Nguyen on 3/13/22.
//

import UIKit
import Foundation

class RapidAPI{

    let headers = [
        "x-rapidapi-host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "x-rapidapi-key': '28575210ecmsha87dd5d0fd9ac22p11aa08jsn7908c981df58'"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/images/analyze?imageUrl=https%3A%2F%2Fspoonacular.com%2FrecipeImages%2F635350-240x150.jpg")! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    
}
    
    
