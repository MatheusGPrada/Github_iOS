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
    
    var segmentedControl = {
       let control = UISegmentedControl(items: ["Cards", "TableView"])
        
        control.selectedSegmentIndex = 0
        control.backgroundColor = .white
        control.layer.cornerRadius = 20
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
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
        list.translatesAutoresizingMaskIntoConstraints = false
        
        return list
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    func setupUI() {
        backgroundColor = .black
        
        repositoriesList.addSubview(repositoriesListContent)
        
        userCard.addSubview(segmentedControl)
        userCard.addSubview(userArrow)
        userCard.addSubview(userImageView)
        userCard.addSubview(userName)
        userCard.addSubview(userBio)
        userCard.addSubview(userLocation)
        userCard.addSubview(userCompany)
        
        addSubview(repositoriesList)
        addSubview(userCard)
        addSubview(tableView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        // MARK: - USER IMAGE CARD
        
        userCard.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-200)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        userImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(userCard.snp.centerX)
            make.top.equalTo(userCard.snp.top).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        userArrow.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(userCard.snp.trailing)
            make.bottom.equalTo(userCard.snp.bottom)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        segmentedControl.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(userCard.snp.centerX)
            make.bottom.equalTo(userCard.snp.bottom)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        // MARK: - USER INFO CARD
        
        userName.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(userCard.snp.centerX)
            make.top.equalTo(userCard.snp.top).offset(20)
        }
        
        userBio.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(userCard.snp.centerX)
            make.top.equalTo(userName.snp.bottom).offset(20)
            make.trailing.equalTo(userCard.snp.trailing).offset(-40)
            make.leading.equalTo(userCard.snp.leading).offset(40)
        }
        
        userLocation.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(userCard.snp.centerX)
            make.top.equalTo(userBio.snp.bottom).offset(20)
            make.trailing.equalTo(userCard.snp.trailing).offset(-40)
            make.leading.equalTo(userCard.snp.leading).offset(40)
        }
        
        userCompany.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(userCard.snp.centerX)
            make.top.equalTo(userLocation.snp.bottom).offset(20)
            make.trailing.equalTo(userCard.snp.trailing).offset(-40)
            make.leading.equalTo(userCard.snp.leading).offset(40)
        }
        
        // MARK: - LIST
        
        repositoriesList.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(snp.centerY)
            make.trailing.equalTo(snp.trailing)
            make.leading.equalTo(snp.leading)
            make.bottom.equalTo(safeAreaInsets.bottom)
        }
        
        repositoriesListContent.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(repositoriesList.snp.top)
            make.bottom.equalTo(repositoriesList.snp.bottom)
            make.leading.equalTo(repositoriesList.snp.leading)
            make.trailing.equalTo(repositoriesList.snp.trailing)
            make.centerX.equalTo(repositoriesList.snp.centerX)
        }
        
        // MARK: - TABLE VIEW
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(snp.centerY)
            make.trailing.equalTo(snp.trailing)
            make.leading.equalTo(snp.leading)
            make.bottom.equalTo(safeAreaInsets.bottom)
        }
    }
}
