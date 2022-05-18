//
//  HomeDetailViewModel.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import Foundation

protocol HomeDetailViewModelDataSource {
    var movieId: Int? {get}
    var movieImageUrl: URL? {get}
    var movieRate: Double? { get}
    var movieTitle: String? { get }
    var movieDefinition: String? {get}
    var movieReleaseData: String? {get}
}

protocol HomeDetailViewEventSource {
    var reloadData: VoidClosure? { get set}
    var endRefreshing: VoidClosure? {get set}
}

protocol HomeDetailViewModelProtocol: HomeDetailViewModelDataSource, HomeDetailViewEventSource {
    
}

//MARK: -
class HomeDetailViewModel: BaseViewModel<HomeDetailRouter>, HomeDetailViewModelProtocol {
    
    var movieImageUrl: URL?
    var movieRate: Double?
    var movieTitle: String?
    var movieDefinition: String?
    var movieReleaseData: String?
    var reloadData: VoidClosure?
    var endRefreshing: VoidClosure?
    var movieId: Int?
    let imgPath: String = "https://image.tmdb.org/t/p/original"
    
    init(movieId: Int?, router: HomeDetailRouter){
            self.movieId = movieId
            super.init(router: router)
    }
    
    private func setData(detailModel: MovieDetailsModel) {
        self.movieTitle = detailModel.title
        self.movieDefinition  = detailModel.overview
        self.movieRate = detailModel.voteAverage
        self.movieImageUrl = URL(string: imgPath + (detailModel.posterPath ?? "") )
        self.movieReleaseData = detailModel.releaseDate
    }
}

//MARK: -  Fetch Data
extension HomeDetailViewModel {
    
    func fetchDetailData() {
          let request = MovieDetailRequest(movieId: movieId ?? 0)
          dataProvider.request(for: request) {  [weak self] result in
              guard let strongSelf = self  else { return }
              switch result {
              case .success(let response):
                  guard let response = response else {return}
                  strongSelf.setData(detailModel: response)
                  strongSelf.reloadData?()
                  strongSelf.endRefreshing?()
              case .failure(let error):
                  strongSelf.endRefreshing?()
                  SnackHelper.showSnack(message: error.localizedDescription)
              }
          }
      }
}
