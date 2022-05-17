//
//  DecodableResponseRequest.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

public protocol DecodableResponseRequest: RequestProtocol {
    associatedtype ResponseType: Decodable
}
