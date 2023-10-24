//
//  HomeView.swift
//  Github
//
//  Created by Matheus Prada on 17/10/23.
//

import UIKit

final class HomeView: UIView {
    var gitImageView: UIImageView = {
        let gitImageView = UIImageView()
        
        gitImageView.contentMode = .scaleAspectFit
        gitImageView.image = UIImage(named: "Logo.jpeg");
        gitImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return gitImageView
    }()
    
    lazy var usernameTextField: UITextField =  {
        let usernameTextField = UITextField()
        
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Nome de usuário"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.text = "MatheusGPrada"
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return usernameTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .black
        
        addSubview(gitImageView)
        addSubview(usernameTextField)
        
        setGitImageConstraints()
        setUsernameInputConstraints()
    }
    
    // MARK: - Constraints
    
    private func setGitImageConstraints() {
        NSLayoutConstraint.activate([
            gitImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: gitImageView.centerYAnchor, constant: 100),
            gitImageView.widthAnchor.constraint(equalToConstant: 200),
            gitImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setUsernameInputConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: gitImageView.centerYAnchor, constant: 100),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
