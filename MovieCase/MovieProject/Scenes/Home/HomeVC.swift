//
//  ViewController.swift
//  MovieCase
//
//  Created by ugur-pc on 11.05.2022.
//

import UIKit
import MobilliumBuilders

class HomeVC: UIViewController {

    
    private let collectionView = UICollectionViewBuilder()
        .showsVerticalScrollIndicator(false)
        .showsHorizontalScrollIndicator(false)
        .backgroundColor(.purple)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
    }


}

//MARK: -
extension HomeVC {
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
}

extension HomeVC {
    private func configureContents(){
        
    }
}

