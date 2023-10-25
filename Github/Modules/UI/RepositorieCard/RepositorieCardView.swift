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
    
    var userRespositoriesView = {
        let view = UIView()
        
        view.layer.cornerRadius = 20
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func setupUI() {
        backgroundColor = .black
        
        userRespositoriesView.addSubview(userRepositoriesLanguage)
        userRespositoriesView.addSubview(userRepositoriesDescription)
        userRespositoriesView.addSubview(userRepositoriesName)
        
        addSubview(userRespositoriesView)
    }
}
