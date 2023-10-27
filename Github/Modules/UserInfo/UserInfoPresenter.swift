//
//  UserInfoPresenter.swift
//  Github
//
//  Created by Matheus Prada on 26/10/23.
//

import Foundation

protocol UserInfoPresenterProtocol {
    func showInfoCard()
    func showUserImageCard()
}

final class UserInfoPresenter {
    
    weak var view: UserInfoViewControllerProtocol?
    
}

extension UserInfoPresenter: UserInfoPresenterProtocol {
    func showInfoCard() {
        view?.showInfoCard()
    }
    
    func showUserImageCard() {
        view?.showUserImageCard()
    }
}
