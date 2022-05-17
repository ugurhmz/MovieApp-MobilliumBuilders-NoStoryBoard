//
//  HomeSliderCellModel.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import Foundation

protocol HomeSliderCellDataSource: AnyObject {
    var movieId: Int? { get }
    var movieImage: URL? {get}
    var movieTitle: String? {get}
    var movieDefinition: String? { get }
    var movieReleaseDate: String? { get }
    var totalPagesIndicator: Int? {get set}
}

protocol HomeSliderCellEventSource: AnyObject {
    
}

protocol HomeSliderCellProtocol: HomeSliderCellDataSource, HomeSliderCellEventSource {
    
}

//MARK: - HomeSliderCellModel
final class HomeSliderCellModel: HomeSliderCellProtocol {
    var movieId: Int?
    var movieImage: URL?
    var movieTitle: String?
    var movieDefinition: String?
    var totalPagesIndicator: Int?
    var movieReleaseDate: String?
    
    public init(id: Int? = nil,
                image: URL? = nil,
                title: String? = nil,
                definition: String? = nil,
                totalPagesIndicator: Int? = nil,
                movieReleaseDate: String? = nil)
    {
        self.movieId = id
        self.movieImage = image
        self.movieTitle = title
        self.movieDefinition = definition
        self.totalPagesIndicator = totalPagesIndicator
        self.movieReleaseDate = movieReleaseDate
        
    }
}
