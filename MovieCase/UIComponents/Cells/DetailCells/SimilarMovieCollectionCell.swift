//
//  SimilarMovieCollectionCell.swift
//  ChallengeApp
//
//  Created by ugur-pc on 8.05.2022.
//

import UIKit
import Kingfisher

class SimilarMovieCollectionCell: UICollectionViewCell {
    static var identifier = "SimilarMovieCollectionCell"
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    private func setupViews(){
        addSubview(movieImageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Fill Data
extension SimilarMovieCollectionCell {
    func fillSimilarData(movieValue: SimilarCellProtocoL) {
        
        guard let movieImg = movieValue.movieImageUrl else {
            return
        }
        self.movieImageView.kf.setImage(with: movieImg )
        self.titleLabel.text = movieValue.movieTitle
    }
}


extension SimilarMovieCollectionCell {
    private func setConstraints(){
        movieImageView.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              bottom: nil,
                              trailing: trailingAnchor,
                              size: .init(width: 0, height: 112 )
        )
        
        titleLabel.anchor(top: movieImageView.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 2, bottom: 10, right: 0)
        )
    }
}

