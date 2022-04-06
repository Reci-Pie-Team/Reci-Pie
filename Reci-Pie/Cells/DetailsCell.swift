//
//  DetailsCell.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/28/22.
//

import UIKit
import Parse

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    var bookmarked: Bool = false
    var id = 0
    var count = 0
    
    func setBookmarked(_ isBookmarked: Bool){
        bookmarked = isBookmarked
        if(bookmarked){
            bookmarkButton.setImage(UIImage(systemName:"bookmark.fill"), for: UIControl.State.normal)
            print("Bookmarked Pressed")
        } else {
            bookmarkButton.setImage(UIImage(systemName:"bookmark"), for: UIControl.State.normal)
            print("Unbookmarked Pressed")
        }
    }
    
    //var bookmarks = PFObject(className: "Bookmarks")
    let bookmarks = Bookmarks()
    var results = [PFObject]()
    
    
    @IBAction func onBookmarkButton(_ sender: Any) {
        let query = PFQuery(className:"Bookmarks")
        let user = PFUser.current()?.objectId
        print(user!)
        print(bookmarks.user)
        query.whereKey("user" , equalTo: user!)
        query.whereKey("recipe" , equalTo: id )
        query.countObjectsInBackground { (i: Int32, error: Error?) in
                        if let error = error {
                            // The request failed
                            print(error.localizedDescription)
                        } else {
                            self.count = Int(i)
                            print("\(self.count) objects found!")
                        }
                    }
//        query.findObjectsInBackground { (objects, error) -> Void in
//            if error == nil {
//                if let returnedObjects = objects {
//                    for object in returnedObjects {
//                        print(object["recipe"] as! Int)
//                        //delete the object
//                        //object!.deleteInBackground
//                    }
//                }
//            }
//        }
//        query.countObjectsInBackground { (count: Int32, error: Error?) in
//            if let error = error {
//                // The request failed
//                print(error.localizedDescription)
//            } else {
//                print("\(count) objects found!")
//            }
//        }
//
        //let result = results["recipe"]
        //let result = results["recipe"]
        
        if (count == 0) {
//            bookmarks["user"] = PFUser.current()
            bookmarks.user = (PFUser.current()?.objectId)!
//            bookmarks["recipe"] = id
            bookmarks.recipe = id
            bookmarks.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                // The object has been saved.
                  self.setBookmarked(true)
              } else {
                // There was a problem, check error.description
              }
            }
        } else {
            
            self.setBookmarked(false)
    }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
