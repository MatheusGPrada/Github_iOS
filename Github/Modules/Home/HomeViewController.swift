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

class HomeView: UIView {
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

class HomeViewController: UIViewController {
    
    var interactor: HomeInteractorProtocol?
    lazy var rootView = HomeView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.usernameTextField.addTarget(self, action: #selector(validTextField), for: .editingDidEndOnExit)
    }
    
    @objc func validTextField(textField: UITextField) {
        guard let username = textField.text else {
            return
        }
        interactor?.validUsername(username: username)
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
