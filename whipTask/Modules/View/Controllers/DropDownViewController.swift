//
//  DropDownViewController.swift
//  whipTask
//
//  Created by madhu sudhan on 23/05/2020.
//  Copyright © 2020 madhu sudhan. All rights reserved.
//

import UIKit

//This controller represnnts filter Types PopView on maincontroller

class DropDownViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectedFilter: FilterType = .all
    
    var didSelectFilter: ((FilterType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}



extension DropDownViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        let filterType = FilterType(rawValue: indexPath.row)!
        cell.textLabel?.text = filterType.value.replacingOccurrences(of: "_", with: " ")
        cell.accessoryType = (selectedFilter.rawValue == indexPath.row) ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilter = FilterType(rawValue: indexPath.row)!
        didSelectFilter?(selectedFilter)
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
}
