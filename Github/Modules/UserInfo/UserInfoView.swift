//
//  UserInfoView.swift
//  Github
//
//  Created by Matheus Prada on 17/10/23.
//

import UIKit

final class UserInfoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userImageView = {
        let userImageView = UIImageView()
        
        userImageView.contentMode = .scaleAspectFit
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return userImageView
    }()
    
    var userNameView = {
        let userName = UILabel()
        
        userName.textColor = .white
        userName.font = UIFont.systemFont(ofSize: 16)
        userName.textAlignment = .center
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        return userName
    }()
    
    func setupUI() {
        backgroundColor = .black
        
        addSubview(userImageView)
        addSubview(userNameView)
        
        setUsernameConstraints()
        setUserImageViewConstraints()
    }
    
// MARK: - CONSTRAINTS
    
    private func setUserImageViewConstraints() {
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 200),
            userImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setUsernameConstraints() {
        NSLayoutConstraint.activate([
            userNameView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNameView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100),
            userNameView.widthAnchor.constraint(equalToConstant: 200),
            userNameView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
