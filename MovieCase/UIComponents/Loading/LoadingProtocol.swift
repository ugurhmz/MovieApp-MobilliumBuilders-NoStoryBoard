//
//  LoadingProtocol.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import UIKit

public protocol LoadingProtocol {
    func presentLoading()
    func dismissLoading()
}

public extension LoadingProtocol where Self: UIViewController {
    
    func presentLoading() {
        let window = UIApplication.shared.windows.first
        window?.startBlockingActivityIndicator()
    }
    
    func  dismissLoading(){
        let window = UIApplication.shared.windows.first
        window?.stopBlockingActivityIndicator()
    }
}
