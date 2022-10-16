//
//  EmployeeCardVC.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 29.07.2022.
//

import UIKit

class EmployeeCardVC: UIViewController {

    
    @IBOutlet weak var lastNameLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var secondNameLable: UILabel!
    @IBOutlet weak var departmentLable: UILabel!
    @IBOutlet weak var jobNameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var telegramLable: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    var item : Employee? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            
            let arrayString = separateName(name: item.name)
            for (index, partName) in arrayString.enumerated() {
                if index == 0 {
                    self.lastNameLable.text = partName
                } else if index == 1 {
                    self.nameLable.text = partName
                } else {
                    self.secondNameLable.text = partName
                }
            }
            
//            self.avatarImage.image       = item.avatar
            self.departmentLable.text    = "Подразделение: \(item.department)"
            self.jobNameLable.text       = "Должность: \(item.jobName)"
            self.emailLable.text         = "Email: \(item.email)"
            self.telegramLable.text      = "Telegram: \(item.telegram)"
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func separateName(name: String) -> [String] {
        
        let arraySubstring = name.split(separator: " ")
        var result : [String] = []
        
        for substing in arraySubstring {
            result.append(String(substing))
        }
        
        return result
        
    }

}
