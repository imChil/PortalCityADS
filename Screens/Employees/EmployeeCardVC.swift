//
//  EmployeeCardVC.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 29.07.2022.
//

import UIKit

class EmployeeCardVC: UIViewController {

    let networkManager = NetworkService()
    let storageManager = StorageManager()
    
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
            
            setupItem(item: item)
            
        }
    }
    
    func separateName(name: String) -> [String] {
        
        let arraySubstring = name.split(separator: " ")
        var result : [String] = []
        
        for substing in arraySubstring {
            result.append(String(substing))
        }
        
        return result
        
    }
    
    func setupItem(item: Employee){
        
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
        
        self.departmentLable.text    = "Подразделение: \(item.department)"
        self.jobNameLable.text       = "Должность: \(item.jobName)"
        self.emailLable.text         = "Email: \(item.email)"
        self.telegramLable.text      = "Telegram: \(item.telegram)"
        
        let image = storageManager.getImageEmployee(id: item.id)
        
        if image == nil {
            networkManager.getImage(id: item.id) { [weak self] image in
                if let dataImage = image.pngData() {
                    self?.storageManager.saveImageEmployee(id: item.id, image: dataImage)
                }
                self?.avatarImage.image = image
            }
        } else {
            self.avatarImage.image = image
        }
        
        self.avatarImage.layer.borderWidth = 5
        self.avatarImage.layer.cornerRadius = 20
        self.avatarImage.layer.masksToBounds = false
        self.avatarImage.layer.borderColor = UIColor.systemCyan.cgColor
        self.avatarImage.clipsToBounds = true
        
    }

}
