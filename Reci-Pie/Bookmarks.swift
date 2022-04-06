//
//  Bookmarks.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 4/5/22.
//

import UIKit
import Parse

class Bookmarks: PFObject, PFSubclassing {
    
    @NSManaged var user: String
       @NSManaged var recipe: Int

    
    static func parseClassName() -> String {
        return "Bookmarks"
    }
    
    
}
