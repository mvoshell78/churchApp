//
//  MediaCustomCell.swift
//  churchApp
//
//  Created by Michael Voshell on 11/3/15.
//  Copyright © 2015 Michael Voshell. All rights reserved.
//

import UIKit

class MediaCustomCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
