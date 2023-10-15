//
//  HomeRouter.swift
//  Github
//
//  Created by Matheus Prada on 14/10/23.
//

import Foundation
import UIKit

class HomeRouter {
    weak var view: HomeViewController?
    
    init(view: HomeViewController) {
        self.view = view
    }
    
    func navigateToUserInfo() {
        let userInfo = UserInfoViewController()
        view?.navigationController?.pushViewController(userInfo, animated: true)
    }
}
