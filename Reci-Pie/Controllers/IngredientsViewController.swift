//
//  IngredientsViewController.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/14/22.
//

import UIKit

class ResultsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

class IngredientsViewController: UIViewController,UISearchResultsUpdating,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var ingredientsCollectionView: UICollectionView!
    
    let searchController = UISearchController()
    var ingredients = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //implement searchBar
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        
        //GET METHOD
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        let layout = ingredientsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "b1d07f8c85msh934d677d78dbc2ap163aa0jsn0e783f5e6216"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=apples&number=1&ignorePantry=true&ranking=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error)
            -> Void in
            if (error != nil) {
                print(error)
            } else {
                do {
                    if let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        self.ingredients = dataDictionary["recipes"] as! [[String:Any]]
                        Dispatch.DispatchQueue.main.async {
                            self.ingredientsCollectionView.reloadData()
                        }
                    
                    }} catch let error as NSError{
                print(error.localizedDescription)
                }
            }
        })
        dataTask.resume()
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsCollectionViewCell", for: indexPath) as! IngredientsCollectionViewCell
        let ingredient = ingredients[indexPath.row]
        let title = ingredient["title"] as! String
        let image = ingredient["image"] as! String
        let imageUrl = URL(string: image)
        
        cell.ingredientImage.af.setImage(withURL: imageUrl!)
        cell.ingredientLabel.text = title
        
        
        return cell
    }


}
