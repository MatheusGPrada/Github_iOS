//
//  UserImageService.swift
//  Github
//
//  Created by Matheus Prada on 17/11/23.
//

import Foundation

protocol UserImageServiceProtocol {
    func getUserImage(avatarUrl: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class UserImageService {
    
    enum ServiceErrors: Error, Equatable {
        case generic
    }
    
    private var imageDataTask: URLSessionDataTask?
    private let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    deinit{
        imageDataTask?.cancel()
    }
}

extension UserImageService: UserImageServiceProtocol {
    func getUserImage(avatarUrl: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        imageDataTask = networkSession.dataTask(with: avatarUrl) { (imageData, _, imageError) in
            guard let imageData = imageData else {
                completion(.failure(ServiceErrors.generic))
                return
            }
            
            completion(.success(imageData))
        }
        
        imageDataTask?.resume()
    }
}
