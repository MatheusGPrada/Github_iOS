//
//  HomeInteractor.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

class HomeInteractor {
    
    lazy var presenter = HomePresenter()
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    func validUsername(username: String) {
        
        if(username.isEmpty){
            presenter.showEmptyUserAlert()
            return
        }
        
        getGithubUserInfo(username: username)
    }
    
    private func getGithubUserInfo(username: String) {
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
            } catch {
                DispatchQueue.main.async {
                    self.presenter.showUserNotFoundAlert()
                }
            }

        }.resume()
    }
}
