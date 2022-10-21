//
//  EmployeeTableVC.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 22.07.2022.
//

import UIKit

class EmployeeTableVC: UITableViewController {
    
    let networkService = NetworkService()
    private let searchEmployee = UISearchController(searchResultsController: nil)
    private var employees = [Employee]()
    private var filtredEmployees = [Employee]()
    private var searchBarisempty: Bool {
        guard let text = searchEmployee.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isSearching: Bool {
        return searchEmployee.isActive && !searchBarisempty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        getEmployees()
        
        searchEmployee.searchResultsUpdater = self
        searchEmployee.obscuresBackgroundDuringPresentation = false
        searchEmployee.automaticallyShowsCancelButton = false
        navigationItem.searchController = searchEmployee
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  isSearching ? filtredEmployees.count : employees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.id, for: indexPath) as? EmployeeCell else {return UITableViewCell()}
        
        let item = isSearching ? filtredEmployees[indexPath.row] : employees[indexPath.row]
        cell.setupItem(employee: item)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmployeeDetail" {
            if let vc = segue.destination as? EmployeeCardVC {
                if let index = self.tableView.indexPathForSelectedRow {
                    let item = isSearching ? filtredEmployees[index.row] : employees[index.row]
                    vc.item = item
                }
            }
        }
    }

}

extension EmployeeTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchController.searchBar.text!)
    }
    
    private func filterContent(_ searchText: String){
        filtredEmployees = employees.filter({(employee: Employee) -> Bool in
            return employee.name.lowercased().contains(searchText.lowercased()) || employee.jobName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
}

extension EmployeeTableVC {

    private func getEmployees(){
        networkService.getEmployees(){ [weak self] result in
            
            if result.success {
                
                DispatchQueue.main.async {
                    self?.employees = result.data
                    self?.getImages()
                    self?.tableView.reloadData()
                }
                
            } else {
                
                print(result.message)
                
            }
        }
    }
    
    private func getImages(){
        for (i, item) in self.employees.enumerated() {
            networkService.getImage(id: item.id) {[weak self] result in

                    DispatchQueue.main.async {
                        self?.employees[i].avatar = result
                        self?.tableView.reloadData()
                        }
                
            }
        }
    }
}
