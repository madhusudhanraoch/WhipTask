//
//  RatingModel.swift
//  whipTask
//
//  Created by madhu sudhan on 22/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

struct Rating: Codable {
    var avg: Int?
    var description: String?
    var items: RatingItems?
    var title: String?
    private enum CodingKeys: String, CodingKey {
        case avg, description, title, items
    }
}

struct RatingItems: Codable {
    var one: Int?
    var two: Int?
    var three: Int?
    var four: Int?
    var five: Int?
    private enum CodingKeys: String, CodingKey {
        case one = "1", two = "2", three = "3", four = "4", five = "5"
    }
}
