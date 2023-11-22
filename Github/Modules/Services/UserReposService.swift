//
//  UserRepos.swift
//  Github
//
//  Created by Matheus Prada on 17/11/23.
//

import Foundation

protocol UserReposServiceProtocol {
    func getUserRepos(reposURL: URL, completion: @escaping (Result<[Repos], Error>) -> Void)
}

final class UserReposService {
    
    enum ServiceErrors: Error, Equatable {
        case reposNotFound
        case reposDecodeError
    }
    
    private var reposDataTask: URLSessionDataTask?
    private let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    deinit{
        reposDataTask?.cancel()
    }
}

extension UserReposService: UserReposServiceProtocol {
    func getUserRepos(reposURL: URL, completion: @escaping (Result<[Repos], Error>) -> Void) {
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
}
