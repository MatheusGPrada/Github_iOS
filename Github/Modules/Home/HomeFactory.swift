//
//  HomeFactory.swift
//  Github
//
//  Created by Matheus Prada on 15/10/23.
//

import UIKit

struct HomeFactory {
    static func build() -> HomeViewController {
        let coordinator = HomeCoordinator()
        let presenter = HomePresenter(coordinator: coordinator)
        let interactor = HomeInteractor(presenter: presenter, networkSession: URLSession.shared)
        let view = HomeViewController(interactor: interactor)
        

        coordinator.viewController = view
        return view
    }
}
