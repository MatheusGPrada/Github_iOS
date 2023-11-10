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
    func showServiceError()
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos])
}

final class HomePresenter {
    
    var coordinator: HomeCoordinator?
    
    enum AlertProps {
        enum EmptyUser {
            static let title = "Usuario vazio"
            static let description = "Informe um usuário"
        }
        enum UserNotFound {
            static let title = "Usuario não encontrado"
            static let description = "Não foi encontrado um usuário do Github com o nome informado"
        }
        enum ServiceError {
            static let title = "Erro de serviço"
            static let description = "Erro ao realizar a requisição"
        }
    }
}

extension HomePresenter: HomePresenterProtocol {
    func showEmptyUserAlert() {
        coordinator?.showErrorAlert(title: AlertProps.EmptyUser.title, description: AlertProps.EmptyUser.description)
    }
    
    func showUserNotFoundAlert() {
        coordinator?.showErrorAlert(title: AlertProps.UserNotFound.title, description: AlertProps.UserNotFound.description)
    }
    
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        coordinator?.showViewController(viewController: UserInfoFactory.build(userInfo: data, imageData: imageData, repos: repos))
    }
    
    func showServiceError() {
        coordinator?.showErrorAlert(title: AlertProps.ServiceError.title, description: AlertProps.ServiceError.description)
    }
}
