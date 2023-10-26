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
        NSLayoutConstraint.activate([
            userRepositoriesName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userRepositoriesName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            userRepositoriesName.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            userRepositoriesDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userRepositoriesDescription.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            userRepositoriesDescription.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: userRepositoriesLanguage.trailingAnchor, constant: 20),
            userRepositoriesLanguage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        ])
    }
}
