//
//  JobModel.swift
//  whipTask
//
//  Created by madhu sudhan on 22/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

//By using this Job Model class we will dispaly Job related info for user on UI


struct Job: Codable {
    var description: String?
    var items: [JobItem]?
    var title: String?
    private enum CodingKeys: String, CodingKey {
        case description, items, title
    }
}

struct JobItem: Codable {
    var avg: String?
    var description: String?
    var growth: NSInteger?
    var title: String?
    var total: Int?
    private enum CodingKeys: String, CodingKey {
        case avg, description, growth, title, total
    }
}
