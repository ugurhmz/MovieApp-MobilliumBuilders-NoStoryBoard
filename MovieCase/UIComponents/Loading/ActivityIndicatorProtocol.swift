//
//  ActivityIndicatorProtocol.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import UIKit

public protocol ActivityIndicatorProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorProtocol where Self: UIViewController {
    
    func showActivityIndicator() {
        let indicator = ActivityIndicatorView(frame: .infinite)
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.centerInSuperview()
        view.bringSubviewToFront(indicator)
        indicator.color = .red
    }
    
    func hideActivityIndicator() {
        view.subviews.filter({ $0 is ActivityIndicatorView }).forEach({ $0.removeFromSuperview() })
    }
}
