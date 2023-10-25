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
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 100
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return userImageView
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
        addSubview(repositoriesList)
        addSubview(userImageView)
        //addSubview(tableView)
        
        setConstraints()
        //setUserRespositoriesConstraints()
        //setTableViewConstraints()
    }
    
// MARK: - CONSTRAINTS
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 200),
            userImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        NSLayoutConstraint.activate([
            repositoriesList.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: repositoriesList.topAnchor, constant: 100),
            repositoriesList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            repositoriesList.leftAnchor.constraint(equalTo: leftAnchor),
            repositoriesList.rightAnchor.constraint(equalTo: rightAnchor),
            repositoriesList.heightAnchor.constraint(equalToConstant: 1800),
            // TO DO - ADD AUTO HEIGHT AND WARNING
        ])
        
        NSLayoutConstraint.activate([
            repositoriesListContent.topAnchor.constraint(equalTo: repositoriesList.topAnchor),
            repositoriesListContent.bottomAnchor.constraint(equalTo: repositoriesList.bottomAnchor),
            repositoriesListContent.leftAnchor.constraint(equalTo: repositoriesList.leftAnchor),
            repositoriesListContent.rightAnchor.constraint(equalTo: repositoriesList.rightAnchor),
            repositoriesListContent.centerXAnchor.constraint(equalTo: repositoriesList.centerXAnchor),
            repositoriesListContent.heightAnchor.constraint(equalToConstant: 1800),
            // TO DO - ADD AUTO HEIGHT AND WARNING
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
