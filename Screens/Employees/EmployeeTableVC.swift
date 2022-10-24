//
//  EmployeeTableVC.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 22.07.2022.
//

import UIKit

class EmployeeTableVC: UITableViewController {
    
    let storageManager = StorageManager()
    let networkService = NetworkService()
    private let searchEmployee = UISearchController(searchResultsController: nil)
    private var employees = [Employee]()
    private var filtredEmployees = [Employee]()
    private var departmentArray = [String]()
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
        return departmentArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let array = isSearching ? filtredEmployees : employees
        let department = departmentArray[section]
        
//        return  isSearching ? filtredEmployees.count : employees.count
        return getCountofSection(sectionName: department, array: array)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.id, for: indexPath) as? EmployeeCell else {return UITableViewCell()}
        let item = getItem(with: indexPath)
        cell.setupItem(employee: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = departmentArray[section]
        return section
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmployeeDetail" {
            if let vc = segue.destination as? EmployeeCardVC {
                if let index = self.tableView.indexPathForSelectedRow {
                    vc.item = getItem(with: index)
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
        fillDepartmentsAraay()
        tableView.reloadData()
    }
    
}

extension EmployeeTableVC {
    
    private func getEmployees(){
        networkService.getEmployees(){ [weak self] result in
            
            if result.success {
                
                DispatchQueue.main.async {
                    self?.employees = convertEmployeeResult(employeeCodable: result.data)
                    self?.getImages()
                    self?.fillDepartmentsAraay()
                    self?.tableView.reloadData()
                }
                
            } else {
                print(result.message)
            }
        }
    }
    
    private func getImages() {
        
        for (i, item) in self.employees.enumerated() {
            
            let image = storageManager.getImageEmployee(id: item.id)
            
            if image == nil {
                networkService.getImage(id: item.id) {[weak self] image in
                    if let dataImage = image.pngData() {
                        self?.storageManager.saveImageEmployee(id: item.id, image: dataImage)
                    }
                    self?.employees[i].avatar = image
                }
            } else {
                self.employees[i].avatar = image
            }
            
        }
    }
    
    private func fillDepartmentsAraay() {
        departmentArray.removeAll()
        let array = isSearching ? filtredEmployees : employees
        for employee in array {
            let index = departmentArray.firstIndex(of: employee.department)
            if index == nil {
                departmentArray.append(employee.department)
            }
        }
    }
    
    private func getCountofSection(sectionName: String, array: [Employee]) -> Int {
        
        var result = 0
        
        for item in array {
            if item.department == sectionName {
                result += 1
            }
        }
        
        return result
    }
    
    private func getEmployees(from employees : [Employee], with department: String) -> [Employee] {
        
        var result : [Employee] = []
        
        for item in employees {
            if item.department == department {
                result.append(item)
            }
        }
        
        return result
    }
    
    private func getItem(with index: IndexPath) -> Employee {
        
        let array = isSearching ? filtredEmployees: employees
        let section = departmentArray[index.section]
        let arrayForSearch = getEmployees(from: array, with: section)
        let item = arrayForSearch[index.row]
        
        return item
    }
    
}
