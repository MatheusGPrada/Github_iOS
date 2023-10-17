//
//  UserInfoFactory.swift
//  Github
//
//  Created by Matheus Prada on 15/10/23.
//

import UIKit

struct UserInfoFactory {
    static func build(userInfo: UserInfo, imageData: Data) -> UIViewController {
        //let presenter = UserInfoPresenter()
        let interactor = UserInfoInteractor()
        let view = UserInfoViewController(interactor: interactor, userInfo: userInfo, imageData: imageData)

        //presenter.view = view
        return view
    }
}

