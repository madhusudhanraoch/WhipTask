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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
        viewModel.initFetchAnalytics()
    }
    
    func initView() {
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        
        AnalyticsSectionCell.registerWithTable(tableView)
        JobItemCell.registerWithTable(tableView)
    }
    
    func initViewModel() {
        viewModel.loadAnalytics = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

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
            return UITableViewCell()
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
            return UITableViewCell()
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

