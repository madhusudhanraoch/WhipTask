//
//  RatingCell.swift
//  whipTask
//
//  Created by madhu sudhan on 23/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import UIKit

class RatingCell: ReusableTableViewCell {

    @IBOutlet weak var avgLbl: UILabel!
    @IBOutlet weak var fiveStarProgressBar: UIProgressView!
    @IBOutlet weak var fourStarProgressBar: UIProgressView!
    @IBOutlet weak var threeStarProgressBar: UIProgressView!
    @IBOutlet weak var twoStarProgressBar: UIProgressView!
    @IBOutlet weak var oneStarProgressBar: UIProgressView!
    @IBOutlet weak var totalRatingsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
