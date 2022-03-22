//
//  RapidAPI.swift
//  Reci-Pie
//
//  Created by Vi Nguyen on 3/13/22.
//

import UIKit
import Foundation

class RapidAPI{

    
    
    func getAPI(request: NSMutableURLRequest, headers: [String:String])-> URLSession{
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        //dataTask.resume()
        return session
        
    }
    
    func visualizeNutrition()->URLSession {
        let headers = [
            "accept": "text/html",
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "28575210ecmsha87dd5d0fd9ac22p11aa08jsn7908c981df58"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/products/%7Bid%7D/nutritionWidget")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        return getAPI(request: request, headers: headers)
        
    }
}
    
    
