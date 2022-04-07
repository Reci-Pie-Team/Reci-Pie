//
//  DetailsInstructionCell.swift
//  Reci-Pie
//
//  Created by Osiel Espinal Castillo on 3/28/22.
//

import UIKit

class DetailsInstructionCell: UITableViewCell {
    
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
