//
//  PieChartCell.swift
//  whipTask
//
//  Created by madhu sudhan on 24/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import UIKit
import Charts

class PieChartCell: ReusableTableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pieChartView.rotationEnabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.holeRadiusPercent = 0.3
        //pieChartView.transparentCircleColor = UIColor.clear
        pieChartView.highlightPerTapEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
