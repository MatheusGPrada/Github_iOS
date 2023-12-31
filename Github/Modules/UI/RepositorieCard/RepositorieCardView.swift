//
//  RepositorieCardView.swift
//  Github
//
//  Created by Matheus Prada on 24/10/23.
//

import UIKit

final class RepositorieCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userRepositoriesName = {
        let repositorieName = UILabel()
        
        repositorieName.font = UIFont.systemFont(ofSize: 24)
        
        repositorieName.translatesAutoresizingMaskIntoConstraints = false
        
        return repositorieName
    }()
    
    var userRepositoriesDescription = {
        let repositoriesDescription = UILabel()
        
        repositoriesDescription.font = UIFont.systemFont(ofSize: 16)
        repositoriesDescription.numberOfLines = 4
        
        repositoriesDescription.translatesAutoresizingMaskIntoConstraints = false
        
        return repositoriesDescription
    }()
    
    var userRepositoriesLanguage = {
        let repositoriesLanguage = UILabel()
        
        repositoriesLanguage.font = UIFont.systemFont(ofSize: 20)
        
        repositoriesLanguage.translatesAutoresizingMaskIntoConstraints = false
        
        return repositoriesLanguage
    }()
    
    func setupUI() {
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userRepositoriesLanguage)
        addSubview(userRepositoriesDescription)
        addSubview(userRepositoriesName)
        
        setConstraints()
    }
    
    func setConstraints() {
        userRepositoriesName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(snp.leading).offset(20)
            make.top.equalTo(snp.top).offset(20)
            make.width.equalTo(200)
        }
        
        userRepositoriesDescription.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(snp.leading).offset(20)
            make.top.equalTo(snp.top).offset(60)
            make.width.equalTo(250)
        }
        
        userRepositoriesLanguage.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(snp.trailing).offset(-20)
            make.top.equalTo(snp.top).offset(20)
        }
    }
}
