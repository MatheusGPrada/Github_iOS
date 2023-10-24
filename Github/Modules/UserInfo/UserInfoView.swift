//
//  UserInfoView.swift
//  Github
//
//  Created by Matheus Prada on 17/10/23.
//

import UIKit

final class UserInfoView: UIView {
    
    var repositorieCardView = RepositorieCardView()
    
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
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 100
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return userImageView
    }()
    
//    var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return tableView
//    }()
    
    func setupUI() {
        backgroundColor = .black
        
        addSubview(repositorieCardView)
        addSubview(userImageView)
        //addSubview(tableView)
        
        setUserImageViewConstraints()
        setUserRespositoriesConstraints()
        //setTableViewConstraints()
    }
    
// MARK: - CONSTRAINTS
    
    private func setUserImageViewConstraints() {
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 200),
            userImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setUserRespositoriesConstraints() {
        NSLayoutConstraint.activate([
            repositorieCardView.userRespositoriesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            repositorieCardView.userRespositoriesView.centerYAnchor.constraint(equalTo: centerYAnchor),
            repositorieCardView.userRespositoriesView.widthAnchor.constraint(equalToConstant: 350),
            repositorieCardView.userRespositoriesView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        NSLayoutConstraint.activate([
            repositorieCardView.userRepositoriesName.leftAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.leftAnchor, constant: 20),
            repositorieCardView.userRepositoriesName.topAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            repositorieCardView.userRepositoriesDescription.leftAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.leftAnchor, constant: 20),
            repositorieCardView.userRepositoriesDescription.topAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.topAnchor, constant: 60),
            repositorieCardView.userRepositoriesDescription.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            repositorieCardView.userRespositoriesView.rightAnchor.constraint(equalTo: repositorieCardView.userRepositoriesLanguage.rightAnchor, constant: 20),
            repositorieCardView.userRepositoriesLanguage.topAnchor.constraint(equalTo: repositorieCardView.userRespositoriesView.topAnchor, constant: 20),
        ])
    }
    
//    private func setTableViewConstraints() {
//        NSLayoutConstraint.activate([
//            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            tableView.widthAnchor.constraint(equalToConstant: 400),
//            tableView.heightAnchor.constraint(equalToConstant: 500),
//        ])
//    }
}
