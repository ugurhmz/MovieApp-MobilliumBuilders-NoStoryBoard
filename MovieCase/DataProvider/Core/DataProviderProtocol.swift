//
//  DataproviderProtocol.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

public typealias DataProviderResult<T: Decodable> = ((Result<T, Error>) -> Void)

public protocol DataProviderProtocol {
    
    func request<T: DecodableResponseRequest>(for request: T,
                                              result: DataProviderResult<T.ResponseType>?)
}
