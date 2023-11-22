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
    
    let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    enum ServiceErrors: Error, Equatable {
        case reposNotFound
    }
}

extension HomePresenter: HomePresenterProtocol {
    func showEmptyUserAlert() {
        coordinator.showErrorAlert(alert: .emptyUser)
    }
    
    func showUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        if repos.count == 0 {
            showServiceError(ServiceErrors.reposNotFound)
            return
        }
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
        case HomePresenter.ServiceErrors.reposNotFound:
            coordinator.showErrorAlert(alert: .reposNotFound)
        default:
            coordinator.showErrorAlert(alert: .serviceError)
        }
    }
}
