//
//  DetailsViewController.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/28/22.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredients = recipe["extendedIngredients"] as! [Any]
        return ingredients.count + 2
    }
    
    var recipe: [String:Any]!
    var information: [String:Any]!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = recipe["title"] as! String
        let instructions = recipe["instructions"] as! String
        let ingredients = recipe["extendedIngredients"] as? [[String:Any]]
        let image = recipe["image"] as! String
        let imageUrl = URL(string: image)
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        
        cell.detailsTitleLabel.text = title
        cell.detailsImageView.af_setImage(withURL: imageUrl!)
            
        return cell
        } else if indexPath.row <= ingredients!.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsIngredientCell") as! DetailsIngredientCell
            
            let ingredient = ingredients?[indexPath.row - 1]
            let ingredientName = ingredient?["originalName"] as! String
            //print(ingredientName)
            cell.ingredientsLabel.text = ingredientName
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsInstructionCell") as! DetailsInstructionCell
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
