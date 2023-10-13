//
//  HomePresenter.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

class HomePresenter {
    
    enum AlertProps {
        enum EmptyUser {
            static let title = "Usuario vazio"
            static let description = "Informe um usuário"
        }
        enum UserNotFound {
            static let title = "Usuario não encontrado"
            static let description = "Não foi encontrado um usuário do Github com o nome informado"
        }
    }

    func showEmptyUserAlert() {
        let viewController = HomeViewController()
        viewController.showErrorAlert(title: AlertProps.EmptyUser.title, description: AlertProps.EmptyUser.description)
    }
    
    func showUserNotFoundAlert() {
        let viewController = HomeViewController()
        viewController.showErrorAlert(title: AlertProps.UserNotFound.title, description: AlertProps.UserNotFound.description)
    }
    
    func navigateToUserInfo() {
//        let vc = SettingsViewController()
//        vc.title = "Settings"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
