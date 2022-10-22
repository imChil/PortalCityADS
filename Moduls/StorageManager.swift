//
//  FileManager.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 21.10.2022.
//

import Foundation
import UIKit

final class StorageManager {
    
    let manager = FileManager.default
    let appSupp = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    func saveImageEmployee(id: String, image: Data) {
        
        if let imageFileUrl = getEmployeeImageFileUrl(id: id) {
            try? image.write(to: imageFileUrl)
        }
        
    }
    
    func getImageEmployee(id: String) -> UIImage? {
        
        if let imageFileUrl = getEmployeeImageFileUrl(id: id) {
            if let fileData = try? Data(contentsOf: imageFileUrl) {
                let image = UIImage(data: fileData)
            
                return image
            }
        }
        
        return nil
    }
    
    private func getEmployeeImageFileUrl(id: String) -> URL? {
        
        if let imageFileUrl = appSupp?.appendingPathComponent("\(id).jpg") {
            return imageFileUrl
        }
        
        return nil
    }
    
}

