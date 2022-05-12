//
//  ViewController.swift
//  MovieCase
//
//  Created by ugur-pc on 11.05.2022.
//

import UIKit
import MobilliumBuilders

class HomeVC: UIViewController {

    
    private let homeCollectionView = UICollectionViewBuilder()
        .showsVerticalScrollIndicator(false)
        .showsHorizontalScrollIndicator(false)
        .backgroundColor(.white)
        .registerCell(HomeTopCell.self,
                      reuseIdentifier: HomeTopCell.identifier)
        .registerCell(HomeBottomCell.self,
                      reuseIdentifier: HomeBottomCell.identifier)
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
        view.addSubview(homeCollectionView)
        homeCollectionView.fillSuperview()
    }
}

extension HomeVC {
    private func configureContents(){
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case MovieTypes.NowPlayingMovies.rawValue:
                return 1
        case MovieTypes.UpComingMovies.rawValue:
            return 5
        default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
         
        // topCell
        case MovieTypes.NowPlayingMovies.rawValue:
            guard let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTopCell.identifier,
                                                                   for: indexPath) as? HomeTopCell else {
                return UICollectionViewCell()
            }
            
            topCell.backgroundColor = .green
            return topCell
            
        // bottomCell
        case MovieTypes.UpComingMovies.rawValue:
            guard let bottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBottomCell.identifier, for: indexPath) as? HomeBottomCell else {
                return UICollectionViewCell()
            }
            
            bottomCell.backgroundColor = .white
            return bottomCell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case MovieTypes.NowPlayingMovies.rawValue:
            return 0
        case  MovieTypes.UpComingMovies.rawValue:
            return 8
        default:
            return 0
        }
    }
    
}

//MARK: -
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
            
        case MovieTypes.NowPlayingMovies.rawValue:
            return CGSize(width: homeCollectionView.frame.width,
                          height: homeCollectionView.frame.width)
            
        case MovieTypes.UpComingMovies.rawValue:
            return CGSize(width: homeCollectionView.frame.width,
                          height: homeCollectionView.frame.width - 264)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case MovieTypes.NowPlayingMovies.rawValue:
            return .zero
        case MovieTypes.UpComingMovies.rawValue:
           return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        default:
            return .zero
        }
    }
    
}
