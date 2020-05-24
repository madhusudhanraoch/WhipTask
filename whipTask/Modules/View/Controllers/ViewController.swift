//
//  ViewController.swift
//  whipTask
//
//  Created by madhu sudhan on 20/05/20.
//  Copyright © 2020 madhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: ViewModel = {
        return ViewModel()
    }()
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var currentScope: FilterType = FilterType.all

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        initView()
        initViewModel()
        viewModel.initFetchAnalytics(scope: currentScope)
    }
    
    func initView()
    {
        self.title = "Dashboard"
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        
        AnalyticsSectionCell.registerWithTable(tableView)
        RatingCell.registerWithTable(tableView)
        JobItemCell.registerWithTable(tableView)
        PieChartCell.registerWithTable(tableView)
        
         setNavigationBarButton()
    }
    
    func initViewModel() {
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicatorView.startAnimating()
                }else {
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }
        
        viewModel.loadAnalytics = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
        func setNavigationBarButton() {
            
    navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: "filterIcon"),
                style: .plain,
                target: self,
                action: #selector(filterTapped(sender:))
            )

        }
        
        @objc func filterTapped(sender: UIBarButtonItem) {
            showScopFilter()
        }
        
        func showScopFilter() {
            guard let dropDownVC = storyboard?.instantiateViewController(withIdentifier: "DropDownViewController") as? DropDownViewController else {
                return
            }
            dropDownVC.modalPresentationStyle = .popover
            dropDownVC.preferredContentSize = CGSize(width: 200, height: 200)
            dropDownVC.didSelectFilter = { [weak self] selectedFilter in
                self?.currentScope = selectedFilter
                if let scope = self?.currentScope {
                   self?.viewModel.initFetchAnalytics(scope: scope)
                }
                print(selectedFilter.value)
            }
            dropDownVC.selectedFilter = currentScope
            
            let ppc = dropDownVC.popoverPresentationController
            ppc?.permittedArrowDirections = .any
            ppc?.delegate = self
            ppc?.barButtonItem = navigationItem.rightBarButtonItem
            present(dropDownVC, animated: true, completion: nil)
        }
        
    }


    extension ViewController: UIPopoverPresentationControllerDelegate {
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
        }
    }

    

// Tableview datasource and delegate methods here to dispaly data for user on UI

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnalyticsSectionCell.reuseIdentifier) as! AnalyticsSectionCell
        cell.titleLbl.text = viewModel.getSectionTitle(TableViewSection(rawValue: section)!).0
        cell.descriptionLbl.text = viewModel.getSectionTitle(TableViewSection(rawValue: section)!).1
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.getSectionHeight(TableViewSection(rawValue: section)!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(TableViewSection(rawValue: section)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TableViewSection(rawValue: indexPath.section)!
        switch section {
        case .rating:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseIdentifier, for: indexPath) as? RatingCell else {
                fatalError("Cell not exists")
            }
            let rating = viewModel.getRating()
            cell.avgLbl.text = rating.avg
            cell.totalRatingsLbl.text = rating.numberOfRatingsString
            cell.oneStarProgressBar.progress = rating.progress(type: .one)
            cell.twoStarProgressBar.progress = rating.progress(type: .two)
            cell.threeStarProgressBar.progress = rating.progress(type: .three)
            cell.fourStarProgressBar.progress = rating.progress(type: .four)
            cell.fiveStarProgressBar.progress = rating.progress(type: .five)
            return cell

        case.jobs:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobItemCell.reuseIdentifier, for: indexPath) as? JobItemCell else {
                fatalError("Cell not exists")
            }
            let item = viewModel.getJobItem(indexPath: indexPath)
            cell.titleLbl.text = item.title
            cell.descriptionLbl.text = item.description
            cell.growthLbl.text = item.growth
            return cell
        case .pieChart:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PieChartCell.reuseIdentifier, for: indexPath) as? PieChartCell else {
                fatalError("Cell not exists")
            }
            let chart = viewModel.getChart(indexPath: indexPath)
            cell.titleLbl.text = chart.title
            cell.descriptionLbl.text = chart.description
            cell.pieChartView.data = chart.pieChartData
            cell.pieChartView.animate(xAxisDuration: 1.5)
            return cell

        case .service:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobItemCell.reuseIdentifier, for: indexPath) as? JobItemCell else {
                fatalError("Cell not exists")
            }
            let item = viewModel.getJobItem(indexPath: indexPath)
            cell.titleLbl.text = item.title
            cell.descriptionLbl.text = item.description
            cell.growthLbl.text = item.growth
            return cell
        }
    }
    
    
}

