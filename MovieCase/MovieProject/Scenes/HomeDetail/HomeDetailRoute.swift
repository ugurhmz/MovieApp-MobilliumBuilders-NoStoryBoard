//
//  HomeDetailRoute.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import Foundation

protocol HomeDetailRoute {
    func pushHomeDetail(movieId: Int)
}

extension HomeDetailRoute where Self: RouterProtocol {

    func pushHomeDetail(movieId: Int) {
        let router = HomeDetailRouter()
        let viewModel = HomeDetailViewModel(movieId: movieId,router: router)
        let viewController = HomeDetailVC(viewModel: viewModel)
        let transition = ModalTransition()
        router.viewController = viewController
        router.openTransition = transition
        open(viewController, transition: transition)
    }
}
