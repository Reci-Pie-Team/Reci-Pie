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
        let recipe = recipes[0]
        let title = recipe["title"] as! String
        let image = recipe["image"] as! String
        let imageUrl = URL(string: image)
        /*let baseUrl = "https://image.tmdb.org/t/p/w185"
        let imagePath = recipe["image_path"] as! String
        let imageUrl = URL(string: baseUrl + imagePath)
        */
       // cell.recipeImageView.af.setImage(withURL: imageUrl!)
       // let title = recipes["title"] as! String
        
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
            "x-rapidapi-key": "28575210ecmsha87dd5d0fd9ac22p11aa08jsn7908c981df58"
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
