//
//  HomeView.swift
//  Github
//
//  Created by Matheus Prada on 17/10/23.
//

import UIKit
import SnapKit

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
        
        setConstraints()
    }
    
    private func setConstraints() {
        gitImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        usernameTextField.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}
