//
//  HomeViewModel.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import Foundation

protocol HomeViewDataSource {

    var homeTopCell: HomeTopCellProtocol? { get }
    var homeNowPlayingMovieArr: [HomeSliderCellProtocol]? { get set}
}

protocol HomeViewEventSource {
    var reloadData: VoidClosure? { get set}
    var endRefreshing: VoidClosure? {get set}
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func fetchNowPlayingMovies()
}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    var homeTopCell: HomeTopCellProtocol?
    var homeNowPlayingMovieArr: [HomeSliderCellProtocol]?
    var reloadData: VoidClosure?
    var endRefreshing: VoidClosure?
    let imgPath: String = "https://image.tmdb.org/t/p/original"
    
    init(router: HomeRouter){
        super.init(router: router)
    }
    

    //MARK: - fetch now playing movies
    func fetchNowPlayingMovies() {
        let request = MovieNowPlayingRequest()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let nowPlayingArr = response?.results?.map({
                    return HomeSliderCellModel(id: $0.id,
                                                image:URL(string: self.imgPath + ($0.poster_path ?? "")) ,
                                               title: $0.title,
                                               definition: $0.overview,
                                               totalPagesIndicator: response?.results?.count,
                                               movieReleaseDate: $0.releaseDate
                    )
                }) else { return}
                self.homeNowPlayingMovieArr = nowPlayingArr
                self.homeTopCell = HomeTopCellModel(homeHeaderCellValues: nowPlayingArr)
                self.endRefreshing?()
                self.reloadData?()
            case .failure(let error):
                self.endRefreshing?()
                SnackHelper.showSnack(message: error.localizedDescription)
            }
        }
    }
    
    
    
}
