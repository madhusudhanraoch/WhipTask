//
//  JobItemCell.swift
//  whipTask
//
//  Created by madhu sudhan on 23/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import UIKit

class JobItemCell: ReusableTableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var growthLbl: UILabel!
    @IBOutlet weak var arrowLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
