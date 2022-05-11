//
//  HomeRoute.swift
//  MovieCase
//
//  Created by ugur-pc on 11.05.2022.
//

import UIKit

protocol HomeRoute {
    func placeOnWindowHome()
}

extension HomeRoute where Self: RouterProtocol {
    func placeOnWindowHome() {
           let router = HomeRouter()
          // let viewModel = HomeViewModel(router: router)
           let viewController = HomeVC()
           let navigationController = MainNavigationController(rootViewController: viewController)
           
           let transition = PlaceOnWindowTransition()
           router.viewController = viewController
           router.openTransition = transition
           
           open(navigationController, transition: transition)
       }
}
