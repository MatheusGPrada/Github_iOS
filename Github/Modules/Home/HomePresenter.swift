//
//  HomePresenter.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation

protocol HomePresenterProtocol {
    func showEmptyUserAlert()
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
    
    func showUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        coordinator.navigateToUserInfo(data: data, imageData: imageData, repos: repos)
    }
    
    func showServiceError(_ error: Error) {
        switch error {
        case UserInfoService.ServiceErrors.userNotFound:
            coordinator.showErrorAlert(alert: .userNotFound)
        case UserReposService.ServiceErrors.reposNotFound:
            coordinator.showErrorAlert(alert: .reposNotFound)
        case UserReposService.ServiceErrors.reposDecodeError:
            coordinator.showErrorAlert(alert: .reposDecodeError)
        default:
            coordinator.showErrorAlert(alert: .serviceError)
        }
    }
}
