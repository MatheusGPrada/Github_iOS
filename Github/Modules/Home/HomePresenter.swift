//
//  HomePresenter.swift
//  Github
//
//  Created by Matheus Prada on 13/10/23.
//

import Foundation
import UIKit

class HomePresenter {

    func showEmptyUserAlert() {
        let alertController = UIAlertController(title: "Usuario vazio", message: "Informe um usuário", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        alertController.show()
    }
    
    func showUserNotFoundAlert() {
        let alertController = UIAlertController(title: "Usuario não encontrado", message: "Não foi encontrado um usuário do Github com o nome informado", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        alertController.show()
    }
    
}
