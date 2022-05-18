//
//  File.swift
//  MovieCase
//
//  Created by ugur-pc on 12.05.2022.
//

import UIKit
import MobilliumBuilders
import Kingfisher

class HomeTopSliderCell: UICollectionViewCell {
    static var identifier = "HomeTopSliderCell"
    
    private let movieImgView = UIImageViewBuilder()
        .backgroundColor(.clear)
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .build()
    
 
    private var transparentView = UIViewBuilder()
        .backgroundColor(.black.withAlphaComponent(0.3))
        .build()
    
    
    private let titleLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 24, weight: .bold))
        .textColor(.white)
        .numberOfLines(2)
        .build()
    
    
    private let definitionLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .medium))
        .textColor(.white)
        .numberOfLines(2)
        .build()
    
    private let labelStackView = UIStackViewBuilder()
        .axis(.vertical)
        .distribution(.fillProportionally)
        .spacing(10)
        .build()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImgView.image = nil
        self.definitionLbl.text = nil
        self.titleLbl.text = nil
        
    }
}


//MARK: - Fill Data
extension HomeTopSliderCell {
    func fillData(movie: HomeSliderCellProtocol){
        if let mvTitle = movie.movieTitle {
            if let movieDate = movie.movieReleaseDate {
                self.titleLbl.text = "\(mvTitle) (\(movieDate.prefix(4)))"
            }
        }
        self.definitionLbl.text = movie.movieDefinition
        self.movieImgView.kf.setImage(with: movie.movieImage)
    }
}

//MARK: - 
extension HomeTopSliderCell {
    
    private func addSubviews() {
        addSubview(movieImgView)
        addSubview(transparentView)
        addSubview(labelStackView)
        
        [titleLbl,definitionLbl].forEach{ labelStackView.addArrangedSubview($0)}
    }
    
    private func setConstraints(){
        movieImgView.anchor(top: contentView.topAnchor,
                                     leading: contentView.leadingAnchor,
                                     bottom: contentView.bottomAnchor,
                                     trailing: contentView.trailingAnchor)
               
        transparentView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                      leading: contentView.leadingAnchor,
                                      bottom: contentView.bottomAnchor,
                                      trailing: contentView.trailingAnchor)
               
        labelStackView.anchor(top: nil,
                                      leading: contentView.leadingAnchor,
                                      bottom: contentView.bottomAnchor,
                                      trailing: contentView.trailingAnchor,
                                      padding: .init(top: 0, left: 15, bottom: 70, right: 15))
    }
}
