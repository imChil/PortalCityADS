//
//  EmployeeCell.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 23.07.2022.
//

import UIKit

extension UITableViewCell {
    static var id: String {
        return String(describing: Self.self)
    }
}

class EmployeeCell: UITableViewCell {


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var jobName: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupItem(employee: Employee){
        self.name.text = employee.name
        self.jobName.text = employee.jobName
        self.avatarImage.image = employee.avatar
    }
    
}
