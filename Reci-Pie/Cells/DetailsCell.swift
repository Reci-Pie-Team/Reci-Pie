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
        } else {
            bookmarkButton.setImage(UIImage(systemName:"bookmark.fill"), for: UIControl.State.normal)
        }
    }
    
    var bookmarks = PFObject(className: "Bookmarks")
    
    @IBAction func onBookmarkButton(_ sender: Any) {
        
        let toBeBookmarked = !bookmarked
        if (toBeBookmarked) {
            bookmarks["user"] = PFUser.current()
            bookmarks["recipe"] = id
            bookmarks.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                // The object has been saved.
              } else {
                // There was a problem, check error.description
              }
            }
            self.setBookmarked(true)
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
