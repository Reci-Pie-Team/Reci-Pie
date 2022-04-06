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
    
    func setBookmarked(_ isBookmarked: Bool){
        bookmarked = isBookmarked
        if(bookmarked){
            bookmarkButton.setImage(UIImage(systemName:"bookmark"), for: UIControl.State.normal)
            print("Unbookmarked Pressed")
        } else {
            bookmarkButton.setImage(UIImage(systemName:"bookmark.fill"), for: UIControl.State.normal)
            print("Bookmarked Pressed")
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
        //query.whereKey(bookmarks.user , equalTo: user!)
        do {
            let results: [PFObject] = try query.findObjects()
            print(bookmarks.recipe)
        } catch {
            print(error)
        }
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
        
        let isBookmarked = !bookmarked
        
        
        if (isBookmarked) {
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
