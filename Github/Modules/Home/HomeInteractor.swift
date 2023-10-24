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

final class HomeInteractor {
    
    let presenter: HomePresenterProtocol
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
    private func getGithubUserInfo(username: String) {
        guard let url = URL(string: Constants.apiURL + username) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode(UserInfo.self, from: data)
                let imageURL = json.avatar_url
                
                URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    let imageData = data!
                    
                    URLSession.shared.dataTask(with: json.repos_url) { (data, response, error) in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }
                        do {
                            let repos = data!
                            let userRepos = try JSONDecoder().decode([Repos].self, from: repos)
                            
                            DispatchQueue.main.async {
                                self?.presenter.navigateToUserInfo(data: json, imageData: imageData, repos: userRepos)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self?.presenter.showUserNotFoundAlert()
                            }
                        }
                    }.resume()
                }.resume()
            } catch {
                DispatchQueue.main.async {
                    self?.presenter.showUserNotFoundAlert()
                }
            }

        }.resume()
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    func validUsername(username: String) {
        if(username.isEmpty){
            presenter.showEmptyUserAlert()
            return
        }
        getGithubUserInfo(username: username)
    }
}
