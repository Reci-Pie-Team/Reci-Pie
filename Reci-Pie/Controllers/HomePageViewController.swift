//
//  HomePageViewController.swift
//  Reci-Pie
//
//  Created by Vi Nguyen on 3/13/22.
//

import UIKit
import Parse
import AlamofireImage

class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var recipes = [[String:Any]]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let recipe = recipes[indexPath.row]
        let title = recipe["title"] as! String
        let image = recipe["image"] as! String
        let imageUrl = URL(string: image)
        
        cell.recipeImageView.af.setImage(withURL: imageUrl!)
        cell.RecipeNameLabel.text = title
        
        
        return cell
    }
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        HomeCollectionView.delegate = self
        HomeCollectionView.dataSource = self
        let layout = HomeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "b1d07f8c85msh934d677d78dbc2ap163aa0jsn0e783f5e6216"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?tags=vegetarian%2Cdessert&number=1&limitLicense=true")! as URL,
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
                        self.recipes = dataDictionary["recipes"] as! [[String:Any]]
                        Dispatch.DispatchQueue.main.async {
                            self.HomeCollectionView.reloadData()
                        }
                    
                    }} catch let error as NSError{
                print(error.localizedDescription)
                }
            }
        })
        dataTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.

        print("Loading up the details screen")
        
        //Find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = HomeCollectionView.indexPath(for: cell)!
        let recipe = recipes[indexPath.row]
        
        // Pass the selected object to the new view controller.
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.recipe = recipe
        
        //HomeCollectionView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate =  windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
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
