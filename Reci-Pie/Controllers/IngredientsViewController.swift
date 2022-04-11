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
    
   // var recipe = [[ingredientstruct]]()
    var muIngredients = ""
    var id = Int()
    
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//
//        print("Loading up the details screen")
//
//        //Find the selected movie
//        let cell = sender as! UICollectionViewCell
//        let indexPath = ingredientsCollectionView.indexPath(for: cell)!
//        let recipe = ingredients[indexPath.row]
//
//        // Pass the selected object to the new view controller.
//        let detailsViewController = segue.destination as! DetailsViewController
//        detailsViewController.recipe = recipe
//
//
//
//        //HomeCollectionView.deselectRow(at: indexPath, animated: true)
//    }
    
    func getMethod() {
   
     //   let searchResults = ""
        let headers = [
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "28575210ecmsha87dd5d0fd9ac22p11aa08jsn7908c981df58"
        ]
    

        // mine b1d07f8c85msh934d677d78dbc2ap163aa0jsn0e783f5e6216
        //https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=apples&number=1&ignorePantry=true&ranking=1
       
        print("calling")
        
                        
        var search = ""
                var ingredients = searchResults
                var i = 0
                let array = ingredients.components(separatedBy: ",")
                while ( i < array.count)
                {
                    let words = array[i].components(separatedBy: " ")
                    var j = 0
                    while ( j < words.count)
                    {
                        search = search + words[j] + "%20"
                        j = j + 1
                    }
                    search = search + "%2C"
                    i = i + 1
                }
        searchResults = search
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=\(searchResults)&number=1&ignorePantry=true&ranking=1")! as URL,
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
           
        async {
            if !searchResults.isEmpty && searchResults.count > 3 {
                getMethod()
            }
        }
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
        let imageUrl = URL(string: ingredients[indexPath.row].image)
       //let image = recipe["image"] as! String
      //cell.ingredientImage = ingredients[indexPath.row].image
        
        id = ingredients[indexPath.row].id
        cell.ingredientLabel.text = ingredients[indexPath.row].title.capitalized
        cell.ingredientImage.contentMode = .scaleAspectFill
        cell.ingredientImage.af.setImage(withURL: imageUrl!)
        print("ID: \(id)")
        
        //cell.ingredientLabel.text = ingredients[""] as! String
        
        
        return cell
    }
    


}
