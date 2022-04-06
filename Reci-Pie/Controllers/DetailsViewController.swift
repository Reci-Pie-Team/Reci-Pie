//
//  DetailsViewController.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/28/22.
//

import UIKit
import AlamofireImage
import Parse

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredients = recipe["extendedIngredients"] as! [Any]
        return ingredients.count + 2
    }
    
    var recipe = [String: Any]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = recipe["title"] as! String
        let instructions = recipe["instructions"] as! String
        let recipeId = recipe["id"] as! Int
        let time = recipe["readyInMinutes"] as! Int
        let ingredients = recipe["extendedIngredients"] as? [[String:Any]]
        let image = recipe["image"] as! String
        
        let imageUrl = URL(string: image)
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        
        cell.id = recipeId
        cell.detailsTitleLabel.text = title
        cell.detailsImageView.af_setImage(withURL: imageUrl!)
            
        return cell
        } else if indexPath.row <= ingredients!.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsIngredientCell") as! DetailsIngredientCell
            
            let ingredient = ingredients?[indexPath.row - 1]
            //let ingredientName = ingredient?["name"] as! String
            //let ingredientUnit = ingredient?["unit"] as! String
            //fix format String(format:"%a",x)
            let ingredientAmount = ingredient?["original"] as! String

            //let fullIngredient = ingredientAmount.stringValue + " " + ingredientUnit + " " + ingredientName
            
            cell.ingredientLabel.text = ingredientAmount
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsInstructionCell") as! DetailsInstructionCell
            
            let timeString = "Ready in " + String(time) + " minutes"
            cell.timeLabel.text = timeString
            cell.instructionsLabel.text = instructions
            
            
            return cell
        }
    }
    
    
    
    @IBOutlet weak var detailsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 600
        
    }

}
