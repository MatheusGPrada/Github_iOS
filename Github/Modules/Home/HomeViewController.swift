//
//  ViewController.swift
//  Github
//
//  Created by Matheus Prada on 12/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gitImageView = gitImageView()
        let usernameTextField = usernameTextField()
        
        self.view.addSubview(gitImageView)
        self.view.addSubview(usernameTextField)
        
        setGitImageConstraints(gitImageView: gitImageView)
        setUsernameInputConstraints(usernameTextField: usernameTextField)
    }
    
    @objc func validTextField(textField: UITextField) {
        guard let username = textField.text else {
            return
        }
        
        HomeInteractor().validUsername(username: username) { [weak self] success in
            DispatchQueue.main.async {
                self?.completionHandler?(success)
            }
        }
    }
    // MARK: - UI Components
    
    private func gitImageView() -> UIView {
        let gitImageView = UIImageView()
        
        gitImageView.contentMode = .scaleAspectFit
        gitImageView.image = UIImage(named: "Logo.jpeg");
        
        return gitImageView
    }
    
    private func usernameTextField() -> UIView {
        let usernameTextField = UITextField()
        
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Nome de usuário"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.addTarget(self, action: #selector(validTextField), for: .editingDidEndOnExit)
        
        return usernameTextField
    }
    
    // MARK: - Constraints
    
    private func setGitImageConstraints(gitImageView: UIView) {
        gitImageView.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: gitImageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: gitImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -100)
            let widthConstraint = NSLayoutConstraint(item: gitImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
            let heightConstraint = NSLayoutConstraint(item: gitImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
            view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    private func setUsernameInputConstraints(usernameTextField: UIView) {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: usernameTextField, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: usernameTextField, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: usernameTextField, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
            let heightConstraint = NSLayoutConstraint(item: usernameTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}


