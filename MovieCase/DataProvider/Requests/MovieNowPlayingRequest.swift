//
//  MovieNowPlayingRequest.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import Foundation

public struct MovieNowPlayingRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = MovieNowPlayingModel?
    public var path: String = "/movie/now_playing"
    public var method: RequestMethod = .get
    
    public init() {}
}
