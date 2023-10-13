//
//  HomeInteractor.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation
import UIKit

class HomeInteractor {
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    func validUsername(username: String, completion: @escaping(Bool) -> Void) {
        
        if(username.isEmpty){
            HomePresenter().showEmptyUserAlert()
            return
        }
        
        getGithubUserInfo(username: username, completion: completion)
    }
    
    private func getGithubUserInfo(username: String, completion: @escaping(Bool) -> Void) {
        guard let url = URL(string: Constants.apiURL + username) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in

            guard let data = data else {
                  return
            }

            do {
                let json = try JSONDecoder().decode(UserInfo.self, from: data)
                print("Result: \(json)")
                completion(true)
            } catch {
                DispatchQueue.main.async {
                    HomePresenter().showUserNotFoundAlert()
                    completion(false)
                }
            }

        }.resume()
    }
}
