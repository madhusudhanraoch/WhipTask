//
//  PieChatModel.swift
//  whipTask
//
//  Created by madhu sudhan on 22/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

//By using this PieChart Model class we will dispaly PieChart related info for user on UI


struct PieChart: Codable {
    var chartType: String?
    var description: String?
    var items: [PieChartItem]?
    var title: String?
    private enum CodingKeys: String, CodingKey {
        case chartType, description, items, title
    }
}

struct PieChartItem: Codable {
    var key: String?
    var value: Float?
    private enum CodingKeys: String, CodingKey {
        case key, value
    }
}
