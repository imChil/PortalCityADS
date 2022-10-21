//
//  EmployeeStructure.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 23.07.2022.
//

import Foundation
import UIKit

struct Employee: Codable {
    let id: String
    let name: String
    let jobName: String
    let department: String
    let email: String
    let telegram: String
    var avatar: UIImage? = nil
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case jobName = "jobName"
        case department = "department"
        case email = "email"
        case telegram = "telegram"
    }
}
