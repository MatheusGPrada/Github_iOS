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
    
    var userCard = {
        let userView = UIView()
        
        userView.backgroundColor = .black
        userView.translatesAutoresizingMaskIntoConstraints = false
        
        return userView
    }()
    
    var userImageView = {
        let userImageView = UIImageView()
        
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.masksToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return userImageView
    }()
    
    var userArrow = {
        let userArrow = UIImageView(image: UIImage(systemName: "arrow.forward"))
        
        userArrow.tintColor = .white
        userArrow.contentMode = .scaleAspectFit
        userArrow.isUserInteractionEnabled = true
        userArrow.translatesAutoresizingMaskIntoConstraints = false
        
        return userArrow
    }()
    
    var userName = {
        let userName = UILabel()
        
        userName.font = UIFont.systemFont(ofSize: 28)
        userName.textColor = .white
        userName.isHidden = true
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        return userName
    }()
    
    var userBio = {
        let userBio = UILabel()
        
        userBio.font = UIFont.systemFont(ofSize: 14)
        userBio.textColor = .white
        userBio.numberOfLines = 3
        userBio.isHidden = true
        userBio.translatesAutoresizingMaskIntoConstraints = false
        
        return userBio
    }()
    
    var userLocation = {
        let userLocation = UILabel()
        
        userLocation.font = UIFont.systemFont(ofSize: 14)
        userLocation.textColor = .white
        userLocation.isHidden = true
        userLocation.translatesAutoresizingMaskIntoConstraints = false
        
        return userLocation
    }()
    
    var userCompany = {
        let userCompany = UILabel()
        
        userCompany.font = UIFont.systemFont(ofSize: 14)
        userCompany.textColor = .white
        userCompany.isHidden = true
        userCompany.translatesAutoresizingMaskIntoConstraints = false
        
        return userCompany
    }()
    
    var repositoriesListContent = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var repositoriesList = {
        let list = UIScrollView()
        list.showsVerticalScrollIndicator = true
        list.isDirectionalLockEnabled = true
        list.showsHorizontalScrollIndicator = false
        //TO DO - Hide gray bar on top
        list.translatesAutoresizingMaskIntoConstraints = false
        
        return list
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
        
        repositoriesList.addSubview(repositoriesListContent)
        
        userCard.addSubview(userArrow)
        userCard.addSubview(userImageView)
        userCard.addSubview(userName)
        userCard.addSubview(userBio)
        userCard.addSubview(userLocation)
        userCard.addSubview(userCompany)
        
        addSubview(repositoriesList)
        addSubview(userCard)
        //addSubview(tableView)
        
        setConstraints()
        //setTableViewConstraints()
    }
    
    private func setConstraints() {
        // MARK: - USER IMAGE CARD
        
        NSLayoutConstraint.activate([
            userCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: userCard.centerYAnchor, constant: 200),
            userCard.widthAnchor.constraint(equalToConstant: 300),
            userCard.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: userCard.centerYAnchor),
            userImageView.centerXAnchor.constraint(equalTo: userCard.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: userCard.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 180),
            userImageView.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        NSLayoutConstraint.activate([
            userCard.trailingAnchor.constraint(equalTo: userArrow.trailingAnchor),
            userCard.bottomAnchor.constraint(equalTo: userArrow.bottomAnchor),
            userArrow.widthAnchor.constraint(equalToConstant: 30),
            userArrow.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // MARK: - USER INFO CARD
        
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: userCard.centerXAnchor),
            userName.topAnchor.constraint(equalTo: userCard.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            userBio.centerXAnchor.constraint(equalTo: userCard.centerXAnchor),
            userBio.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20),
            userCard.trailingAnchor.constraint(equalTo: userBio.trailingAnchor, constant: 40),
            userBio.leadingAnchor.constraint(equalTo: userCard.leadingAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            userLocation.centerXAnchor.constraint(equalTo: userCard.centerXAnchor),
            userLocation.topAnchor.constraint(equalTo: userBio.bottomAnchor, constant: 10),
            userCard.trailingAnchor.constraint(equalTo: userLocation.trailingAnchor, constant: 40),
            userLocation.leadingAnchor.constraint(equalTo: userCard.leadingAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            userCompany.centerXAnchor.constraint(equalTo: userCard.centerXAnchor),
            userCompany.topAnchor.constraint(equalTo: userLocation.bottomAnchor, constant: 10),
            userCard.trailingAnchor.constraint(equalTo: userCompany.trailingAnchor, constant: 40),
            userCompany.leadingAnchor.constraint(equalTo: userCard.leadingAnchor, constant: 40),
        ])
        
        // MARK: - LIST
        
        NSLayoutConstraint.activate([
            repositoriesList.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: repositoriesList.topAnchor, constant: 50),
            repositoriesList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            repositoriesList.leadingAnchor.constraint(equalTo: leadingAnchor),
            repositoriesList.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            repositoriesListContent.topAnchor.constraint(equalTo: repositoriesList.topAnchor),
            repositoriesListContent.bottomAnchor.constraint(equalTo: repositoriesList.bottomAnchor),
            repositoriesListContent.leadingAnchor.constraint(equalTo: repositoriesList.leadingAnchor),
            repositoriesListContent.trailingAnchor.constraint(equalTo: repositoriesList.trailingAnchor),
            repositoriesListContent.centerXAnchor.constraint(equalTo: repositoriesList.centerXAnchor),
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
