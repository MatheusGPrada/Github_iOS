//
//  HomeCoordinator.swift
//  Github
//
//  Created by Matheus Prada on 31/10/23.
//

import Foundation
import UIKit


final class HomeCoordinator {
    
    weak var viewController: UIViewController?
    
    struct AlertProps {
        let title: String
        let description: String
        
        static let emptyUser: AlertProps = .init(title: "Usuario vazio", description: "Informe um usuário")
        
        static let userNotFound: AlertProps = .init(title: "Usuario não encontrado", description: "Não foi encontrado um usuário do Github com o nome informado")
        
        static let serviceError: AlertProps = .init(title: "Erro de serviço", description: "Erro ao realizar a requisição")
    }
    
    //TO DO - WEAK VAR ?
    //TO DO - navigateToUserInfo PARAM TO STRUCT
    
    func navigateToUserInfo(data: UserInfo, imageData: Data, repos: [Repos]) {
        DispatchQueue.main.async {
            let userInfoViewController = UserInfoFactory.build(userInfo: data, imageData: imageData, repos: repos)
            self.viewController?.navigationController?.pushViewController(userInfoViewController, animated: true)
        }
    }
    
    func showErrorAlert(alert: AlertProps){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: alert.title, message: alert.description, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
