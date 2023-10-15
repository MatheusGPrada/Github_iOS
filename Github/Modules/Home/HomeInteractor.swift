//
//  HomeInteractor.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

protocol HomeInteractorProtocol {
    func validUsername(username: String)
}

class HomeInteractor {
    
    var presenter: HomePresenterProtocol?
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    init(presenter: HomePresenterProtocol?) {
        self.presenter = presenter
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
                DispatchQueue.main.async {
                    self.presenter?.saveDataAndNavigate(data: json)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.showUserNotFoundAlert()
                }
            }

        }.resume()
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    func validUsername(username: String) {
        if(username.isEmpty){
            presenter?.showEmptyUserAlert()
            return
        }
        getGithubUserInfo(username: username)
    }
}
