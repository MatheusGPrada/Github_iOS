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
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    init(presenter: HomePresenterProtocol, networkSession: NetworkSession) {
        self.presenter = presenter
        self.networkSession = networkSession
    }
    
    enum ServiceErrors: Error, Equatable {
        case generic
        case userNotFound
        case imageNotFound
        case reposNotFound
        case reposDecodeError
    }
    
    //TO DO - REFACTOR NEW SEVICE FILE
    private var userDataTask: URLSessionDataTask?
    private func getUserInfo(username: String, completion: @escaping (Result<UserInfo, Error>) -> Void ) {
        guard let url = URL(string: Constants.apiURL + username) else {
            completion(.failure(ServiceErrors.generic))
            return
        }
        
        userDataTask = networkSession.dataTask(with: url) { (data, res, err) in
            guard let data = data else {
                completion(.failure(ServiceErrors.generic))
                return
            }
            
            do {
                let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                completion(.success(userInfo))
            }catch{
                completion(.failure(ServiceErrors.userNotFound))
            }
        }
        userDataTask?.resume()
    }
    
    private var imageDataTask: URLSessionDataTask?
    private func getUserImage(avatarUrl: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        imageDataTask = networkSession.dataTask(with: avatarUrl) { (imageData, _, imageError) in
            guard let imageData = imageData else {
                completion(.failure(ServiceErrors.imageNotFound))
                return
            }
            
            completion(.success(imageData))
        }
        
        imageDataTask?.resume()
    }
    
    private var reposDataTask: URLSessionDataTask?
    private func getUserRepos(reposURL: URL, completion: @escaping (Result<[Repos], Error>) -> Void) {
        reposDataTask = networkSession.dataTask(with: reposURL) { (reposData, _, reposError) in
            
            guard let reposData = reposData else {
                completion(.failure(ServiceErrors.reposNotFound))
                return
            }
            
            do {
                let userRepos = try JSONDecoder().decode([Repos].self, from: reposData)
                completion(.success(userRepos))
            } catch {
                completion(.failure(ServiceErrors.reposDecodeError))
            }
        }
        
        reposDataTask?.resume()
    }
    
    deinit{
        userDataTask?.cancel()
        imageDataTask?.cancel()
        reposDataTask?.cancel()
    }
    
    func getUserRepos(userInfo: UserInfo, imageData: Data) {
        getUserRepos(reposURL: userInfo.repos_url) { [weak self] result in
            
            switch result {
            case let .success(repos):
                self?.presenter.showUserInfo(data: userInfo, imageData: imageData, repos: repos)
            case let .failure(error):
                self?.presenter.showServiceError(error)
            }
        }
    }
    
    func getUserImage(userInfo: UserInfo) {
        getUserImage(avatarUrl: userInfo.avatar_url) { [weak self] result in
            
            switch result {
            case let .success(imageData):
                self?.getUserRepos(userInfo: userInfo, imageData: imageData)
            case .failure:
                //TO DO - ADD DEFAULT IMAGE
                self?.getUserRepos(userInfo: userInfo, imageData: .init())
            }
        }
    }
    
    func getGithubUserInfo(username: String) {
        getUserInfo(username: username) { [weak self] result in
            switch result {
            case let .success(userInfo):
                self?.getUserImage(userInfo: userInfo)
            case let .failure(error):
                self?.presenter.showServiceError(error)
            }
        }
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
