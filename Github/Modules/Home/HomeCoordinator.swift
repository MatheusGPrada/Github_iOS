//
//  HomeCoordinator.swift
//  Github
//
//  Created by Matheus Prada on 31/10/23.
//

import Foundation
import UIKit


final class HomeCoordinator {
    
    weak var homeViewController: HomeViewController?
    
    init(viewController: HomeViewController) {
        self.homeViewController = viewController
    }
    
    func showViewController(viewController: UIViewController) {
        homeViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showErrorAlert(title: String, description: String){
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        homeViewController?.present(alertController, animated: true, completion: nil)
    }
}
