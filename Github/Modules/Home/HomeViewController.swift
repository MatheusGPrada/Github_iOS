//
//  ViewController.swift
//  Github
//
//  Created by Matheus Prada on 12/10/23.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func showErrorAlert(title: String, description: String)
    func showViewController(viewController: UIViewController)
}

class HomeViewController: UIViewController {
    
    var interactor: HomeInteractorProtocol?
    
    private var gitImageView: UIImageView = {
        let gitImageView = UIImageView()
        
        gitImageView.contentMode = .scaleAspectFit
        gitImageView.image = UIImage(named: "Logo.jpeg");
        gitImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return gitImageView
    }()
    
    private lazy var usernameTextField: UITextField =  {
        let usernameTextField = UITextField()
        
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Nome de usuário"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.addTarget(self, action: #selector(validTextField), for: .editingDidEndOnExit)
        
        return usernameTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        self.view.addSubview(gitImageView)
        self.view.addSubview(usernameTextField)
        
        setGitImageConstraints()
        setUsernameInputConstraints()
    }
    
    @objc func validTextField(textField: UITextField) {
        guard let username = textField.text else {
            return
        }
        interactor?.validUsername(username: username)
    }
    
    // MARK: - Constraints
    
    private func setGitImageConstraints() {
        NSLayoutConstraint.activate([
            gitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: gitImageView.centerYAnchor, constant: 100),
            gitImageView.widthAnchor.constraint(equalToConstant: 200),
            gitImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setUsernameInputConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: gitImageView.centerYAnchor, constant: 100),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func showViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showErrorAlert(title: String, description: String){
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        present(alertController, animated: true, completion: nil)
    }

}
