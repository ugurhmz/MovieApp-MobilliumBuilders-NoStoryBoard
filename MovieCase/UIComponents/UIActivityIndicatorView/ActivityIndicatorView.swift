//
//  ActivityIndicatorView.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import UIKit
public class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style = .large
        tintColor = .blue
        hidesWhenStopped = true
    }
    
}
