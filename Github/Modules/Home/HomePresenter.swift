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
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos])
}

final class HomePresenter {
    
    weak var view: HomeViewControllerProtocol?
    
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
}

extension HomePresenter: HomePresenterProtocol {
    func showEmptyUserAlert() {
        view?.showErrorAlert(title: AlertProps.EmptyUser.title, description: AlertProps.EmptyUser.description)
    }
    
    func showUserNotFoundAlert() {
        view?.showErrorAlert(title: AlertProps.UserNotFound.title, description: AlertProps.UserNotFound.description)
    }
    
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        view?.showViewController(viewController: UserInfoFactory.build(userInfo: data, imageData: imageData, repos: repos))
    }
}
