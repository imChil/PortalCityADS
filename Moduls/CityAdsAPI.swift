//
//  CityAdsAPI.swift
//  PortalCityAds
//
//  Created by  Pavel Chilin on 22.07.2022.
//

import Foundation

func loginCityAds (login: String, password: String, completion: @escaping  (LoginResponse)->Void) {
    
    let param = "?login=\(login)&password=\(password)"
    guard let url = URL(string: "https://1c.cityads.com/LF/hs/portal/login\(param)") else {
        return
    }
    
    let delegate = HTTPBasicAuthenticationSessionTaskDelegate(user:"1CBilling", password:"s1wjFI7WDtUwpgj")
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: delegate, delegateQueue: nil)
    let task = session.dataTask(with: url) { data, response, error in
        
        guard let parsData = data else { return }
        
        if let loginResult = try? JSONDecoder().decode(LoginResponse.self, from: parsData) {
        
            DispatchQueue.main.sync {
                completion(loginResult)
            }
        } 
        
    }
    
    task.resume()
    
}
