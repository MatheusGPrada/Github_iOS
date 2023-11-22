//
//  HomeCoordinator.swift
//  Github
//
//  Created by Matheus Prada on 31/10/23.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos])
    func showErrorAlert(alert: HomeCoordinatorAlertProps)
}

extension HomeCoordinatorProtocol {
    var thread: HomeCoordinatorProtocol {
        HomeCoordinatorThreadWrapper(coordinator: self)
    }
}

class HomeCoordinatorThreadWrapper: HomeCoordinatorProtocol {
    
    let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        DispatchQueue.main.async {
            self.coordinator.navigateToUserInfo(data: data, imageData: imageData, repos: repos)
        }
    }
    
    func showErrorAlert(alert: HomeCoordinatorAlertProps) {
        DispatchQueue.main.async {
            self.coordinator.showErrorAlert(alert: alert)
        }
    }
    
}

struct HomeCoordinatorAlertProps {
    let title: String
    let description: String
    
    static let emptyUser: Self = .init(title: "Usuario vazio", description: "Informe um usuário")
    static let userNotFound: Self = .init(title: "Usuario não encontrado", description: "Não foi encontrado um usuário do Github com o nome informado")
    static let serviceError: Self = .init(title: "Erro de serviço", description: "Erro ao realizar a requisição")
    static let reposNotFound: Self = .init(title: "Repositórios não encontrados", description: "O usuário informado não possui repositórios")
    static let reposDecodeError: Self = .init(title: "Erro no decode dos repos", description: "Ocorreu um erro no decode dos repositórios")
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    
    typealias AlertProps = HomeCoordinatorAlertProps
    weak var viewController: UIViewController?
    
    //TO DO - WEAK VAR ?
    //TO DO - MOVE IMAGE AND REPO SERVICE TO UserInfoInteractor
    
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
//        DispatchQueue.main.async {
            let userInfoViewController = UserInfoFactory.build(userInfo: data, imageData: imageData, repos: repos)
            self.viewController?.navigationController?.pushViewController(userInfoViewController, animated: true)
//        }
    }
    
    func showErrorAlert(alert: AlertProps){
        //DispatchQueue.main.async {
            let alertController = UIAlertController(title: alert.title, message: alert.description, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.viewController?.present(alertController, animated: true, completion: nil)
        //}
    }
}
