//
//  SortTableViewController.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 05.01.2021.
//

import UIKit

final class SortTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    private let array: [String] = ["By Cost", "By Rating","By Real Distance"]
    weak var delegate: FilterDelegate?
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: self.tableView.contentSize.height)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            delegate?.fetchData(sortBy: .cost)
        case 1:
            delegate?.fetchData(sortBy: .rating)
        case 2:
            self.delegate?.getLocation()
            delegate?.fetchData(sortBy: .distance)
        default:
            delegate?.fetchData(sortBy: .none)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
