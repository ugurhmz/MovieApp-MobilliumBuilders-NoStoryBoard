//
//  HomeBottomCellModel.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import Foundation

protocol HomeBottomCellDataSource: AnyObject {
    var mvId: Int? { get }
    var mvImg: URL? { get }
    var mvTitle: String? { get }
    var mvDefinition: String? { get }
    var mvReleaseDate: String? { get }
}

protocol HomeBottomCellEventSource: AnyObject {
    
}

protocol HomeBottomCellProtocol: HomeBottomCellDataSource, HomeBottomCellEventSource {
    
}

//MARK: - Model
final class HomeBottomCellModel: HomeBottomCellProtocol {
    
    var mvId: Int?
    var mvImg: URL?
    var mvTitle: String?
    var mvDefinition: String?
    var mvReleaseDate: String?
    
    
    
    public init(mvId: Int? = nil,
                mvImg: URL? = nil,
                mvTitle: String? = nil,
                mvDefinition: String? = nil,
                mvReleaseDate: String? = nil)
    {
        self.mvId = mvId
        self.mvImg = mvImg
        self.mvTitle = mvTitle
        self.mvDefinition = mvDefinition
        self.mvReleaseDate = mvReleaseDate
    }
    
}
