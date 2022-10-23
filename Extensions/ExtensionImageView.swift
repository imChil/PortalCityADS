//
//  ExtensionViews.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 23.10.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
}
