//
//  UserInfoInteractor.swift
//  Github
//
//  Created by Matheus Prada on 16/10/23.
//

import Foundation

protocol UserInfoInteractorProtocol {
    func flipCard(isUserImageCard: Bool)
}

class UserInfoInteractor {
    
    let presenter: UserInfoPresenterProtocol
    
    init(presenter: UserInfoPresenterProtocol) {
        self.presenter = presenter
    }
}

extension UserInfoInteractor: UserInfoInteractorProtocol {
    func flipCard(isUserImageCard: Bool) {
        if(isUserImageCard){
            presenter.showInfoCard()
        } else {
            presenter.showUserImageCard()
        }
    }
}
