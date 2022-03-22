//
//  DetailedViewController.swift
//  Reci-Pie
//
//  Created by Vi Nguyen on 3/17/22.
//

import UIKit
import Foundation

class DetailedViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(id: "479101")
        
        // Do any additional setup after loading the view.
    }
    
    func getRecipe(id: String){
    //@IBAction func getMenuButton(_ sender: Any) {
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "28575210ecmsha87dd5d0fd9ac22p11aa08jsn7908c981df58"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: ("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/" + id + "/information"))! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            if (error != nil) {
                print(error)
            }
            else {
                //let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
                 // if let data = data, let dataString = String(data: data, encoding: .utf8){
               
                    do {
                          if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                               
                               // Print out entire dictionary
                               //print(convertedJsonIntoDict)
                               
                               // Get value by key
                              let title = convertedJsonIntoDict["title"]
                              let instruction = convertedJsonIntoDict["instructions"]
                              
                              DispatchQueue.main.async {
                                  self.titleLabel.text = title as? String
                                  self.instructionLabel.text = instruction as? String
                                          }
                               
                           }
                    } catch let error as NSError {
                           print(error.localizedDescription)
                }
                
                      
                    
           
                /*
                if let data = data, let dataString = String(data: data, encoding: .utf8){
                    print(dataString)
                    message = dataString
                    DispatchQueue.main.async {
                        self.DisplayNutrition.text = message
                                }
                    
                }
                 */
                /*
                
                do {
                          if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                               
                               // Print out entire dictionary
                               //print(convertedJsonIntoDict)
                               
                               // Get value by key
                               let userId = convertedJsonIntoDict["id"]
                              
                              self.DisplayNutrition.text = userId as? String
                               
                           }
                } catch let error as NSError {
                           print(error.localizedDescription)
                }
                 */
                
            }
        })
        
        dataTask.resume()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
