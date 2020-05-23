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
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var updateLoadingStatus: (()->())?
    var loadAnalytics: (()->())?
    
   func initFetchAnalytics(scope: FilterType) {
            
            guard !isLoading else { return }
            isLoading = true
            
            APIService().request(router: .getDashboard(scope: scope)) { [weak self] (result: Result<ResponseModel, APIError>) in
                self?.isLoading = false
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
        
        func getRating() -> RatingData {
            guard let rating = analytics?.rating else {
                fatalError("rating not exists")
            }
            return RatingData(rating: rating)
        }

    }

    struct RatingData {
        private let rating: Rating
        
        init(rating: Rating) {
            self.rating = rating
        }
        
        public var title: String {
            return rating.title ?? ""
        }
        
        public var description: String {
            return rating.description ?? ""
        }
        
        public var avg: String {
            return String(rating.avg ?? 0)
        }
        
        public var totalNumberOfRatings: Int {
            guard let items = rating.items else {
                return 0
            }
            let one = items.one ?? 0
            let two = items.two ?? 0
            let three = items.three ?? 0
            let four = items.four ?? 0
            let five = items.five ?? 0
            let total = one + two + three + four + five
            return total
        }
        
        public var numberOfRatingsString: String {
            return "\(totalNumberOfRatings) Ratings"
        }
        
        func progress(type: RatingType) -> Float {
            guard let items = rating.items else {
                fatalError("rating items not exists")
            }
            var value = 0
            switch type {
            case .one:
                value = items.one ?? 0
            case .two:
                value = items.two ?? 0
            case .three:
                value = items.three ?? 0
            case .four:
                value = items.four ?? 0
            case .five:
                value = items.five ?? 0
            }
            let progress = Float(value) / Float(totalNumberOfRatings)
            return progress
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
            if isGrowthDown {
                let negaivegrowth = -(item.growth ?? 0)
                return "\(negaivegrowth)%"
            }else {
                return "\(item.growth ?? 0)%"
            }
        }
        public var isGrowthDown: Bool {
            if let growth = item.growth {
                return (growth < 0) ? true : false
            }
            return false
        }
        
        var arrowText: String {
            return isGrowthDown ? "↓" : "↑"
        }
        
    }
