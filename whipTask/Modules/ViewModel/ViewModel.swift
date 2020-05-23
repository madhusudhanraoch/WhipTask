//
//  ViewModel.swift
//  whipTask
//
//  Created by madhu sudhan on 23/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import Foundation
import UIKit


class ViewModel {
    
    var analytics: Analytics?
    
    var numberOfSections: Int {
        var count = 0
        if analytics?.rating != nil {
            count += 1
        }
        if (analytics?.job) != nil {
            count += 1
        }
        if (analytics?.pieCharts) != nil {
            count += 1
        }
        if (analytics?.service) != nil {
            count += 1
        }
        return count
    }
    
    var loadAnalytics: (()->())?
    
    func initFetchAnalytics()
    {
        APIService().request(router: .getDashboard(scope: .all)) { [weak self] (result: Result<ResponseModel, APIError>) in
            switch result {
            case .success(let response):
                if let analyticsResponse = response.response?.data?.analytics {
                    self?.analytics = analyticsResponse
                    self?.loadAnalytics?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSectionTitle(_ section: TableViewSection) -> (String, String) {
        switch section {
        case .rating:
            guard let rating = analytics?.rating else {
                return ("", "")
            }
            return (rating.title ?? "", rating.description ?? "")
        case .jobs:
            guard let job = analytics?.job else {
                return ("", "")
            }
            return (job.title ?? "", job.description ?? "")
        case .pieChart:
            return ("PieChart", "PieChart Description")
        case .service:
            guard let service = analytics?.service else {
                return ("", "")
            }
            return (service.title ?? "", service.description ?? "")
        }
    }
    
    func getSectionHeight(_ section: TableViewSection) -> CGFloat {
        switch section {
        case .rating:
            guard (analytics?.rating) != nil else {
                return 0
            }
            return UITableView.automaticDimension
        case .jobs:
            guard (analytics?.job) != nil else {
                return 0
            }
            return UITableView.automaticDimension
        case .pieChart:
            return 0
        case .service:
            guard (analytics?.service) != nil else {
                return 0
            }
            return UITableView.automaticDimension
        }
    }
    
    func numberOfRows(_ section: TableViewSection) -> Int {
        switch section {
        case .rating:
            return 1
        case .jobs:
            guard let jobItems = analytics?.job?.items else {
                return 0
            }
            return jobItems.count
        case .pieChart:
            guard let pieCharts = analytics?.pieCharts else {
                return 0
            }
            return pieCharts.count
        case .service:
            guard let serviceItems = analytics?.service?.items else {
                return 0
            }
            return serviceItems.count
        }
    }
    
    func getJobItem(indexPath: IndexPath) -> JobItemData {
        let section = TableViewSection(rawValue: indexPath.section)!
        guard let items = (section == .jobs) ? analytics?.job?.items : analytics?.service?.items else {
            fatalError("item not exists")
        }
        return JobItemData(item: items[indexPath.row])
    }

}

struct JobItemData {
    private let item: JobItem
    
    init(item: JobItem) {
        self.item = item
    }
    
    public var title: String {
        return item.title ?? ""
    }
    public var description: String {
        return item.description ?? ""
    }
    public var growth: String {
        return "\(item.growth ?? 0)%"
    }
    
}
