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
    func showServiceError(_ error: Error)
    func showUserInfo(data: UserInfo, imageData: Data, repos: [Repos])
}

final class HomePresenter {
    
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenterProtocol {
    func showEmptyUserAlert() {
        coordinator.showErrorAlert(alert: .emptyUser)
    }
    
    func showUserNotFoundAlert() {
        coordinator.showErrorAlert(alert: .userNotFound)
    }
    
    func showUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        coordinator.navigateToUserInfo(data: data, imageData: imageData, repos: repos)
    }
    
    //TO DO - ADD ERROR SERVICE
    func showServiceError(_ error: Error) {
        switch error {
            //TO DO - REMOVE SERVICERROR FROM INTERACTOR
        case HomeInteractor.ServiceErrors.userNotFound:
            showUserNotFoundAlert()
        default:
            coordinator.showErrorAlert(alert: .serviceError)
        }
    }
}
