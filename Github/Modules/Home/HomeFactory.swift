//
//  HomeFactory.swift
//  Github
//
//  Created by Matheus Prada on 15/10/23.
//

import UIKit

struct HomeFactory {
    static func build() -> HomeViewController {
        let networkSession = URLSession.shared
        let coordinator = HomeCoordinator()
        let thread = HomeCoordinatorThreadWrapper(coordinator: coordinator)
        let presenter = HomePresenter(coordinator: thread)
        
        let userInfoService = UserInfoService(networkSession: networkSession)
        let userImageService = UserImageService(networkSession: networkSession)
        let userReposService = UserReposService(networkSession: networkSession)
        
        let interactor = HomeInteractor(presenter: presenter, networkSession: networkSession, userInfoService: userInfoService, userImageService: userImageService, userReposService: userReposService)
        let view = HomeViewController(interactor: interactor)
        

        coordinator.viewController = view
        return view
    }
}
