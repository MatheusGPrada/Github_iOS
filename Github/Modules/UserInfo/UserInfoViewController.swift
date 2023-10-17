//
//  UserInfoViewController.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var interactor: UserInfoInteractorProtocol?
    
    var userInfo: UserInfo = {
        let encoded = UserDefaults.standard.value(forKey: "user_info") as! Data
        return try! JSONDecoder().decode(UserInfo.self, from: encoded)
    }()
    
    private func userImageView() -> UIImageView {
        let userImageView = UIImageView()
        
        if let imageURL = URL(string: userInfo.avatar_url) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        userImageView.image = image
                    }
                }
            }.resume()
        }
        
        userImageView.contentMode = .scaleAspectFit
//        let userImage = interactor?.getUserImage(url: userInfo.avatar_url)
//        userImageView.image = UIImage(data: userImage!)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return userImageView
    }
    
    private func userNameView() -> UILabel {
        let userName = UILabel()
        
        userName.text = userInfo.login
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 16)
        userName.textAlignment = .center
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        return userName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userNameView = userNameView()
        let userImage = userImageView()
        
        view.backgroundColor = .white
        
        view.addSubview(userNameView)
        view.addSubview(userImage)
        
        setUsernameConstraints(userNameView: userNameView)
        setUserImageConstraints(userImage: userImage)
    }
    
    private func setUsernameConstraints(userNameView: UILabel) {
        NSLayoutConstraint.activate([
            userNameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            userNameView.widthAnchor.constraint(equalToConstant: 200),
            userNameView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setUserImageConstraints(userImage: UIImageView) {
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: userImage.centerYAnchor, constant: 100),
            userImage.widthAnchor.constraint(equalToConstant: 200),
            userImage.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
