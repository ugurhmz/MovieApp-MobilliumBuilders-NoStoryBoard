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
    var homeUpComingArr: [HomeBottomCellProtocol]? { get set}
}

protocol HomeViewEventSource {
    var reloadData: VoidClosure? { get set}
    var endRefreshing: VoidClosure? {get set}
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    var isLoading: Bool { get set}
    var increasePage: Int {get set}
    func getMoreMovieData()
    func fetchNowPlayingMovies()
    func didSelectItem(at indexPath: IndexPath)
}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    var increasePage: Int = 1
    var isLoading: Bool = false
    var homeUpComingArr: [HomeBottomCellProtocol]?  // upcoming
    var homeTopCell: HomeTopCellProtocol?
    var homeNowPlayingMovieArr: [HomeSliderCellProtocol]?   //now_playing
    var reloadData: VoidClosure?
    var endRefreshing: VoidClosure?
    let imgPath: String = "https://image.tmdb.org/t/p/original"
    
    init(router: HomeRouter){
        super.init(router: router)
    }
    

    //MARK: - FETCH NOW_PLAYINGS
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
    
    
    //MARK: - FETCH UPCOMING
    func fetchUpComingMovies(page: Int?){
        let request = MovieUpComingRequest(page: page ?? 1)
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else {return }
            switch result {
            case .success(let response):
                guard let movieArr = response?.results?.map({
                    return HomeBottomCellModel(mvId: $0.id,
                                               mvImg: URL(string: self.imgPath + ($0.posterPath ?? "" )),
                                               mvTitle: $0.title,
                                               mvDefinition: $0.overview,
                                               mvReleaseDate: $0.releaseDate)
                }) else { return }
                self.homeUpComingArr = movieArr
                self.endRefreshing?()
                self.reloadData?()
            case .failure(let error):
                self.endRefreshing?()
                SnackHelper.showSnack(message: error.localizedDescription)
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let selectedId = homeUpComingArr?[indexPath.item].mvId ?? 0
        router.pushHomeDetail(movieId: selectedId)
    }
}


//MARK: -
extension HomeViewModel {
    func getMoreMovieData(){
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                sleep(UInt32(1.2))
                
                if self.homeUpComingArr?.isEmpty == false {
                    self.increasePage += 1
                    self.fetchUpComingMovies(page: self.increasePage)
                } else {
                    self.increasePage = 1
                    self.fetchUpComingMovies(page: self.increasePage)
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
