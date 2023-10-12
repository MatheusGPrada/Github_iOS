//
//  ViewController.swift
//  Github
//
//  Created by Matheus Prada on 12/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(createGitImageView())
        self.view.addSubview(createUsernameInput())
    }
    
    private func createGitImageView() -> UIView {
        let gitImageView = UIImageView(frame: CGRect(x: (view.width / 2) - 100, y: (view.height / 2) - 200, width: 200, height: 200))
        gitImageView.contentMode = .scaleAspectFit
        
        let gitImage = UIImage(named: "Logo.jpeg");
        gitImageView.image = gitImage;
        return gitImageView
    }
    
    private func createUsernameInput() -> UIView {
        let usernameTextField = UITextField(frame: CGRect(x: (view.width / 2) - 100, y: (view.height / 2), width: 200, height: 50))
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Nome de usuário"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.addTarget(self, action: #selector(getUserRepositories), for: .editingDidEndOnExit)
        
        return usernameTextField
    }
    
    @objc private func getUserRepositories(textField: UITextField) {
        guard let username = textField.text else {
            return
        }
        if(username.isEmpty){
            let alertController = UIAlertController(title: "Usuario vazio", message: "Informe um usuário", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion: nil)
        } else {
            print("Username \(username)")
            // Request and navigate to list
        }
    }
}

