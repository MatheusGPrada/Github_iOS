//
//  UserInfoService.swift
//  Github
//
//  Created by Matheus Prada on 17/11/23.
//

import Foundation

class UserInfoService {
    
    private struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
    enum ServiceErrors: Error, Equatable {
        case generic
        case userNotFound
    }
    
    private var userDataTask: URLSessionDataTask?
    private let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    func getUserInfo(username: String, completion: @escaping (Result<UserInfo, Error>) -> Void ) {
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
    
    deinit{
        userDataTask?.cancel()
    }
}
