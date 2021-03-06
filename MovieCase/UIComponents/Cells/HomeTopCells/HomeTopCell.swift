//
//  HomeTopCell.swift
//  MovieCase
//
//  Created by ugur-pc on 12.05.2022.
//

import UIKit
import MobilliumBuilders

class HomeTopCell: UICollectionViewCell {
    static var identifier = "HomeTopCell"
    weak var movieViewModel: HomeTopCellProtocol?
    var itemClosure: IndexPathClosure?
    
    private let topCellCollectionView = UICollectionViewBuilder()
        .scrollDirection(.horizontal)
        .showsVerticalScrollIndicator(false)
        .showsHorizontalScrollIndicator(false)
        .isPagingEnabled(true)
        .registerCell(HomeTopSliderCell.self,
                      reuseIdentifier: HomeTopSliderCell.identifier)
        .build()
        
    
    private let pageControl = UIPageControlBuilder()
        .currentPageIndicatorTintColor(.white)
        .pageIndicatorTintColor(.darkGray)
        .numberOfPages(4)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: - Fill Data
extension HomeTopCell {
    func setData(movieData: HomeTopCellProtocol){
        self.movieViewModel = movieData
        self.pageControl.numberOfPages = movieData.numberOfItems
        self.topCellCollectionView.reloadData()
    }
}

// MARK -
extension HomeTopCell {
    private func addSubviews(){
        addSubview(topCellCollectionView)
        addSubview(pageControl)
        topCellCollectionView.dataSource = self
        topCellCollectionView.delegate = self
        
        self.pageControl.numberOfPages = 5
    }
    
    private func setConstraints(){
        topCellCollectionView.fillSuperview()
        
        pageControl.centerXInSuperview()
        pageControl.anchor(top: nil,
                           leading: nil,
                           bottom: bottomAnchor,
                           trailing: nil,
                           padding: .init(top: 0, left: 0, bottom: 10, right: 0))
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeTopCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.pageControl.currentPage = indexPath.row
     }
        
        
    // paging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / topCellCollectionView.frame.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieViewModel?.numberofItemsAtSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        guard let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTopSliderCell.identifier, for: indexPath) as? HomeTopSliderCell else {
            return UICollectionViewCell()
        }
        
        if let cellData = self.movieViewModel?.cellForItem(indexPath: indexPath) {
            sliderCell.fillData(movie: cellData)
        }
        return sliderCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.itemClosure?(indexPath)
    }
    
}

//MARK: -
extension HomeTopCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: topCellCollectionView.frame.width,
                      height: topCellCollectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

