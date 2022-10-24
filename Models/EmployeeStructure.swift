//
//  EmployeeStructure.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 23.07.2022.
//

import Foundation
import UIKit

struct EmployeeCodable: Codable {
    let id: String
    let name: String
    let jobName: String
    let department: String
    let email: String
    let telegram: String
}
    

struct Employee {
    let id: String
    let name: String
    let jobName: String
    let department: String
    let email: String
    let telegram: String
    var avatar: UIImage? = nil
}


func convertEmployeeResult(employeeCodable: [EmployeeCodable]) -> [Employee] {
    
    var employeeArray : [Employee] = []
    
    for item in employeeCodable {
        let employee = Employee(id: item.id, name: item.name, jobName: item.jobName, department: item.department, email: item.email, telegram: item.telegram, avatar: nil)
        employeeArray.append(employee)
    }
    
    return employeeArray
}

