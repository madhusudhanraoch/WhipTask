//
//  Constants.swift
//  whipTask
//
//  Created by madhu sudhan on 21/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

enum FilterType: Int, CaseIterable {
    case all = 0
    case today = 1
    case last_seven_days = 2
    case last_thirty_days = 3
    
    var value: String {
        switch self {
        case .all:
            return "ALL"
        case .today:
            return "TODAY"
        case .last_seven_days:
            return "LAST_7_DAYS"
        case .last_thirty_days:
            return "LAST_30_DAYS"
        }
    }
}

enum TableViewSection: Int {
    case rating = 0
    case jobs = 1
    case pieChart = 2
    case service = 3
}

enum RatingType: Int {
    case one
    case two
    case three
    case four
    case five
}
