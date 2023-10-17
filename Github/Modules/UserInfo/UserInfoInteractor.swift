//
//  UserInfoInteractor.swift
//  Github
//
//  Created by Matheus Prada on 16/10/23.
//

import Foundation

protocol UserInfoInteractorProtocol {
    func getUserImage(url: String) -> Data?
}

class UserInfoInteractor {
    
    //var presenter: HomePresenterProtocol?
    
    struct Constants {
        static let apiURL = "https://api.github.com/users/"
    }
    
//    init(presenter: HomePresenterProtocol?) {
//        self.presenter = presenter
//    }
}

extension UserInfoInteractor: UserInfoInteractorProtocol {
    func getUserImage(url: String) -> Data? {
        
        var imageData: Data?
        
        if let imageURL = URL(string: url) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                let data = data
                print("Inside: \(String(describing: data))")
                imageData = data
            }.resume()
        }
        return imageData
    }
}
