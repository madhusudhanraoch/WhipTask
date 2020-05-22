//
//  Router.swift
//  whipTask
//
//  Created by madhu sudhan on 21/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation

enum Router {
    case getDashboard(scope: FilterType)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "skyrim.whipmobility.io"
    }
    
    var path: String {
        switch self {
        case .getDashboard:
            return "/v10/analytic/dashboard/operation/mock"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getDashboard(let scope):
            return [URLQueryItem(name: "scope", value: scope.rawValue)]
        }
    }
    
    var method: String {
        switch self {
        case .getDashboard:
            return "GET"
        }
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.parameters
        return components
    }
}
