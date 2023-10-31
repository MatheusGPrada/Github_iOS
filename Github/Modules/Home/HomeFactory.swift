//
//  HomeFactory.swift
//  Github
//
//  Created by Matheus Prada on 15/10/23.
//

import UIKit

struct HomeFactory {
    static func build() -> UIViewController {
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let view = HomeViewController(interactor: interactor)
        let coordinator = HomeCoordinator(viewController: view)

        presenter.coordinator = coordinator
        return view
    }
}
