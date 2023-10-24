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
    
//    var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return tableView
//    }()
    
    func setupUI() {
        backgroundColor = .black
        
        addSubview(userImageView)
        //addSubview(tableView)
        
        setUserImageViewConstraints()
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
    
//    private func setTableViewConstraints() {
//        NSLayoutConstraint.activate([
//            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            tableView.widthAnchor.constraint(equalToConstant: 400),
//            tableView.heightAnchor.constraint(equalToConstant: 500),
//        ])
//    }
}
