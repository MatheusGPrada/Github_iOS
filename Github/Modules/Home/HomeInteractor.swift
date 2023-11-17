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

protocol NetworkSession {
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

final class HomeInteractor {
    
    let presenter: HomePresenterProtocol
    let networkSession: NetworkSession
    lazy var userInfoService = UserInfoService(networkSession: networkSession)
    lazy var userImageService = UserImageService(networkSession: networkSession)
    lazy var userReposService = UserReposService(networkSession: networkSession)
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    init(presenter: HomePresenterProtocol, networkSession: NetworkSession) {
        self.presenter = presenter
        self.networkSession = networkSession
    }
    
    func getUserRepos(userInfo: UserInfo, imageData: Data) {
        userReposService.getUserRepos(reposURL: userInfo.repos_url) { [weak self] result in
            switch result {
            case let .success(repos):
                self?.presenter.showUserInfo(data: userInfo, imageData: imageData, repos: repos)
            case let .failure(error):
                self?.presenter.showServiceError(error)
            }
        }
    }
    
    func getUserImage(userInfo: UserInfo) {
        userImageService.getUserImage(avatarUrl: userInfo.avatar_url) { [weak self] result in
            switch result {
            case let .success(imageData):
                self?.getUserRepos(userInfo: userInfo, imageData: imageData)
            case let .failure(error):
                self?.presenter.showServiceError(error)
            }
        }
    }
    
    func getGithubUserInfo(username: String) {
        userInfoService.getUserInfo(username: username, completion: { [weak self] result in
            switch result {
            case let .success(userInfo):
                self?.getUserImage(userInfo: userInfo)
            case let .failure(error):
                self?.presenter.showServiceError(error)
            }
        })
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
