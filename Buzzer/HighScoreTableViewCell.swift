//
//  HighScoreTableViewCell.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-06-13.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
