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
        
        userView.layer.cornerRadius = 20
        userView.backgroundColor = .white
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
        
        userArrow.tintColor = .black
        userArrow.contentMode = .scaleAspectFit
        userArrow.isUserInteractionEnabled = true
        userArrow.translatesAutoresizingMaskIntoConstraints = false
        
        return userArrow
    }()
    
    var userInfo = {
        let repositoriesName = UILabel()
        
        repositoriesName.font = UIFont.systemFont(ofSize: 20)
        repositoriesName.text = "Matheus"
        repositoriesName.isHidden = true
        repositoriesName.translatesAutoresizingMaskIntoConstraints = false
        
        return repositoriesName
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
        userCard.addSubview(userInfo)
        
        addSubview(repositoriesList)
        addSubview(userCard)
        //addSubview(tableView)
        
        setConstraints()
        //setUserRespositoriesConstraints()
        //setTableViewConstraints()
    }
    
    private func setConstraints() {
        // MARK: - USER CARD
        
        NSLayoutConstraint.activate([
            userCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: userCard.centerYAnchor, constant: 200),
            userCard.widthAnchor.constraint(equalToConstant: 350),
            userCard.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: userCard.centerYAnchor),
            userImageView.topAnchor.constraint(equalTo: userCard.topAnchor, constant: 10),
            userImageView.leadingAnchor.constraint(equalTo: userCard.leadingAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 180),
            userImageView.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        NSLayoutConstraint.activate([
            userCard.trailingAnchor.constraint(equalTo: userArrow.trailingAnchor, constant: 20),
            userCard.bottomAnchor.constraint(equalTo: userArrow.bottomAnchor, constant: 20),
            userArrow.widthAnchor.constraint(equalToConstant: 40),
            userArrow.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            userInfo.centerXAnchor.constraint(equalTo: userCard.centerXAnchor),
            userInfo.centerYAnchor.constraint(equalTo: userCard.centerYAnchor),
            userInfo.leadingAnchor.constraint(equalTo: userCard.leadingAnchor),
            userInfo.widthAnchor.constraint(equalToConstant: 40),
            userInfo.heightAnchor.constraint(equalToConstant: 40),
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
