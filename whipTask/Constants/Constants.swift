//
//  Constants.swift
//  whipTask
//
//  Created by madhu sudhan on 21/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

enum FilterType: String {
    case all = "ALL"
    case today = "TODAY"
    case last_seven_days = "LAST_7_DAYS"
    case last_thirty_days = "LAST_30_DAYS"
}

enum TableViewSection: Int {
    case rating = 0
    case jobs = 1
    case pieChart = 2
    case service = 3
}
