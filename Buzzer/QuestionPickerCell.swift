//
//  QuestionPickerCell.swift
//  Buzzer
//
//  Created by Rafael Simon Maia on 2016-05-10.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

class QuestionPickerCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    var answered: Bool = false {
        didSet {
            priceLabel.hidden = answered
        }
    }
}