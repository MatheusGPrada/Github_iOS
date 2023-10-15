//
//  HomePresenter.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

protocol HomePresenterProtocol {
    func showEmptyUserAlert()
    func showUserNotFoundAlert()
    func saveDataAndNavigate(data: UserInfo)
}

class HomePresenter {
    
    private weak var view: HomeViewControllerProtocol?
    
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
    
    init(view: HomeViewControllerProtocol?) {
        self.view = view
    }
}

extension HomePresenter: HomePresenterProtocol {
    func showEmptyUserAlert() {
        view?.showErrorAlert(title: AlertProps.EmptyUser.title, description: AlertProps.EmptyUser.description)
    }
    
    func showUserNotFoundAlert() {
        view?.showErrorAlert(title: AlertProps.UserNotFound.title, description: AlertProps.UserNotFound.description)
    }
    
    func saveDataAndNavigate(data: UserInfo) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "user_info")
        }
        view?.showViewController(viewController: UserInfoFactory.build())
    }
}
