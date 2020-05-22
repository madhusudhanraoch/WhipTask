//
//  ServiceResponseModel.swift
//  whipTask
//
//  Created by Anudeep Gone on 20/05/20.
//  Copyright © 2020 Anudeep. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    var httpStatus: Int?
    var response: Response?
    private enum CodingKeys: String, CodingKey {
        case httpStatus
        case response
    }
}

struct Response: Codable {
    var message: String?
    var data: DataModel?
    private enum CodingKeys: String, CodingKey {
        case message
        case data
    }
}

struct DataModel: Codable {
    var analytics: Analytics?
    private enum CodingKeys: String, CodingKey {
        case analytics
    }
}

struct Analytics: Codable {
    var job: Job?
    private enum CodingKeys: String, CodingKey {
        case job
    }
}
