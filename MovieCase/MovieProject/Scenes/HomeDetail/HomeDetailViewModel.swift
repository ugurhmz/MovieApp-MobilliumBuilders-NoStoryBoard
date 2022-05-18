//
//  HomeDetailViewModel.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import Foundation

class HomeDetailViewModel: BaseViewModel<HomeDetailRouter> {
    
    var movieId: Int?
    
    init(movieId: Int?, router: HomeDetailRouter){
            self.movieId = movieId
            super.init(router: router)
     }
    
}
