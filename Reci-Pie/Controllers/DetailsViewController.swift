//
//  DetailsViewController.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/28/22.
//

import UIKit
import AlamofireImage
import Parse

class DetailsViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let ingredients = recipe["extendedIngredients"] as! [Any]
//        return ingredients.count + 2
//    }
    
    var id = Int()
    
    var recipe = [String: Any]()
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let title = recipe["title"] as! String
//        let instructions = recipe["instructions"] as! String
//        let recipeId = recipe["id"] as! Int
//        let time = recipe["readyInMinutes"] as! Int
//        let ingredients = recipe["extendedIngredients"] as? [[String:Any]]
//        let image = recipe["image"] as! String
//
//        let imageUrl = URL(string: image)
//        if indexPath.row == 0 {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
//
//        cell.id = recipeId
//        cell.detailsTitleLabel.text = title
//        cell.detailsImageView.af_setImage(withURL: imageUrl!)
//
//        return cell
//        } else if indexPath.row <= ingredients!.count {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsIngredientCell") as! DetailsIngredientCell
//
//            let ingredient = ingredients?[indexPath.row - 1]
//            //let ingredientName = ingredient?["name"] as! String
//            //let ingredientUnit = ingredient?["unit"] as! String
//            //fix format String(format:"%a",x)
//            let ingredientAmount = ingredient?["original"] as! String
//
//            //let fullIngredient = ingredientAmount.stringValue + " " + ingredientUnit + " " + ingredientName
//
//            cell.ingredientLabel.text = ingredientAmount
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsInstructionCell") as! DetailsInstructionCell
//
//            let timeString = "Ready in " + String(time) + " minutes"
//            cell.timeLabel.text = timeString
//            cell.instructionsLabel.text = instructions
//
//
//            return cell
//        }
//    }
    
    
    
    @IBOutlet weak var detailsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        async {
            getRequest()
            print(self.recipe)
        }
        
        //print(self.recipe)
        
//        detailsTableView.delegate = self
//        detailsTableView.dataSource = self
//
//        detailsTableView.rowHeight = UITableView.automaticDimension
//        detailsTableView.estimatedRowHeight = 600
        
    }
    
    func getRequest() {
        let headers = [
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "004c37dd5cmsh9aab957ca1366a7p1202b5jsna52015101f56"
        ]

        print(id)
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/information")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    self.recipe = json as! [String: Any]
                    let ingredients = self.recipe["extendedIngredients"] as! [[String:Any]]
                    let ingredient = ingredients[0]
                    print(ingredient["name"])
                    Dispatch.DispatchQueue.main.async {
                        self.detailsTableView.reloadData()
                    }

                } catch {
                    print(error)
                    
                }
            }
        })
        dataTask.resume()
    }
}


