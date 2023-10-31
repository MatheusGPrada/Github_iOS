//
//  ViewController.swift
//  Github
//
//  Created by Matheus Prada on 12/10/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let interactor: HomeInteractorProtocol
    lazy var rootView = HomeView()
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        interactor.validUsername(username: username)
    }
}
