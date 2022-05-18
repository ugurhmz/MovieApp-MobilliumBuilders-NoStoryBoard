//
//  MovieDetailRequest.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import Foundation

public struct MovieDetailRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = MovieDetailsModel?

    public var path: String = "movie/{movieId}"
    public var method: RequestMethod = .get
    
    public init(movieId: Int){
        path = "/movie/\(movieId)"
    }
    
}
