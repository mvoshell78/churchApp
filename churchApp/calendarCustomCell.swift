//
//  calendarCustomCell.swift
//  churchApp
//
//  Created by Michael Voshell on 11/4/15.
//  Copyright © 2015 Michael Voshell. All rights reserved.
//

import UIKit

class calendarCustomCell : UITableViewCell {
    
   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

