//
//  IngredientsViewController.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/14/22.
//

import UIKit
import AlamofireImage


class ResultsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class IngredientsViewController: UIViewController,UISearchResultsUpdating,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var ingredientsCollectionView: UICollectionView!
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var ingredients = [ingredientstruct]()
    var searchResults = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        //implement searchBar
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
     //   let searchResults = searchController.searchBar.text
        
     //   print(searchResults)
        //GET METHOD
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        let layout = ingredientsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
       
       
    }
    
    func getMethod() {
        //video one
     //   let searchResults = ""
        
        let headers = [
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "b1d07f8c85msh934d677d78dbc2ap163aa0jsn0e783f5e6216"
        ]

        //https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=apples&number=1&ignorePantry=true&ranking=1
       
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=\(searchResults)&number=2&ignorePantry=true&ranking=1")! as URL,
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
             //   print(httpResponse)
            }
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                 //   print(json)
                    self.ingredients = try JSONDecoder().decode([ingredientstruct].self, from: data)
                    
                    Dispatch.DispatchQueue.main.async {
                        self.ingredientsCollectionView.reloadData()
                    }

                } catch {
                    print(error)
                    
                }
            }
        })

        dataTask.resume()
    }

    func updateSearchResults(for searchController: UISearchController) {
        
            searchResults = searchController.searchBar.text as! String
            let headers = [
                "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                "X-RapidAPI-Key": "b1d07f8c85msh934d677d78dbc2ap163aa0jsn0e783f5e6216"
            ]

            //https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=apples&number=1&ignorePantry=true&ranking=1
           
            print("calling")
            let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=\(searchResults)&number=2&ignorePantry=true&ranking=1")! as URL,
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
                 //   print(httpResponse)
                }
                if let data = data {
                    print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                     //   print(json)
                        self.ingredients = try JSONDecoder().decode([ingredientstruct].self, from: data)
                        
                        Dispatch.DispatchQueue.main.async {
                            self.ingredientsCollectionView.reloadData()
                        }

                    } catch {
                        print(error)
                        
                    }
                }
            })

            dataTask.resume()
          
            return
        
        
     //   let vc = searchController.searchResultsController as? ResultsVC
        
       //    print(text)
        // ingredientsCollectionView.reloadData()
       // print(searchResults)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsCollectionViewCell", for: indexPath) as! IngredientsCollectionViewCell
    //    let ingredient = ingredients[indexPath.row]
     //   let title = ingredient["title"] as! String
       // let image = ingredient["image"] as! String
    //    let imageUrl = URL(string: image)
        
     //   cell.ingredientImage.af.setImage(withURL: imageUrl!)
      //  cell.ingredientLabel.text = title
        let imageUrl = URL(string: ingredients[indexPath.row].image)
       // let image = recipe["image"] as! String
      //  cell.ingredientImage = ingredients[indexPath.row].image
        cell.ingredientLabel.text = ingredients[indexPath.row].title.capitalized
        cell.ingredientImage.contentMode = .scaleAspectFill
        cell.ingredientImage.af.setImage(withURL: imageUrl!)
        
        
        return cell
    }
    


}
