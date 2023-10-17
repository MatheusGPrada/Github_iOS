//
//  UserInfoFactory.swift
//  Github
//
//  Created by Matheus Prada on 15/10/23.
//

import UIKit

struct UserInfoFactory {
    static func build() -> UIViewController {
        let view = UserInfoViewController()
//        let presenter = HomePresenter(view: view)
        let interactor = UserInfoInteractor()
        
        view.interactor = interactor
        
        return view
    }
}

