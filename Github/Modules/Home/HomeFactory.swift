//
//  HomeFactory.swift
//  Github
//
//  Created by Matheus Prada on 15/10/23.
//

import UIKit

struct HomeFactory {
    static func build() -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter(view: view)
        let interactor = HomeInteractor(presenter: presenter)
        
        view.interactor = interactor
        
        return view
    }
}
