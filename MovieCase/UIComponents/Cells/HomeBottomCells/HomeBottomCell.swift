//
//  HomeBottomCell.swift
//  MovieCase
//
//  Created by ugur-pc on 12.05.2022.
//

import UIKit
import MobilliumBuilders

class HomeBottomCell: UICollectionViewCell {
    static var identifier = "HomeBottomCell"
    
    private let movieImgView = UIImageViewBuilder()
        .backgroundColor(.clear)
        .contentMode(.scaleToFill)
        .cornerRadius(10)
        .clipsToBounds(true)
        .build()
    
    private let titleLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 21, weight: .bold))
        .textColor(.black)
        .numberOfLines(2)
        .build()
    
    private let definitionLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .medium))
        .textColor(.darkGray)
        .numberOfLines(2)
        .build()
    
 
    private let goDetailIcon = UIImageViewBuilder()
        .image(UIImage(systemName: "chevron.right") ?? UIImage())
        .contentMode(.scaleAspectFit)
        .tintColor(.darkGray)
        .build()
    
    private let releaseDateLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .regular))
        .text("26-04-1994")
        .textColor(.darkGray)
        .build()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
}


//MARK: -
extension HomeBottomCell {
    func setData(movieVal: HomeBottomCellProtocol){
        guard let movieImageUrl = movieVal.mvImg else { return}
        self.definitionLbl.text = movieVal.mvDefinition
        if let mvTitle = movieVal.mvTitle {
            if let movieDate = movieVal.mvReleaseDate {
                self.titleLbl.text = "\(mvTitle) (\(movieDate.prefix(4)))"
            }
        }
        self.movieImgView.kf.setImage(with: movieImageUrl)
        self.releaseDateLbl.text = movieVal.mvReleaseDate
    }
}

//MARK: -
extension HomeBottomCell {
    private func addSubviews(){
        addSubview(movieImgView)
        addSubview(titleLbl)
        addSubview(definitionLbl)
        addSubview(goDetailIcon)
        addSubview(releaseDateLbl)
        
        contentView.addBorder(toSide: .Bottom, withColor: UIColor.lightGray.cgColor, andThickness: 0.7)
    }
    
    private func setConstraints(){
        movieImgView.anchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: nil,
                            padding: .init(top: 15, left: 20, bottom: 15, right: 5),
                            size: .init(width: 120, height: 0))
        titleLbl.anchor(top: topAnchor,
                        leading: movieImgView.trailingAnchor,
                        bottom: nil,
                        trailing: trailingAnchor,
                        padding: .init(top: 20, left: 8, bottom: 0, right: 35))
        
        definitionLbl.anchor(top: titleLbl.bottomAnchor,
                             leading: movieImgView.trailingAnchor,
                             bottom: nil,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top:5, left: 8, bottom: 8, right: 45))
        
        goDetailIcon.anchor(top: titleLbl.bottomAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: contentView.trailingAnchor,
                            padding: .init(top: 10, left: 20, bottom: 10, right: 5),
                            size: .init(width: 0, height: 35))
        
        releaseDateLbl.anchor(top: definitionLbl.bottomAnchor,
                              leading: nil,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              padding: .init(top: 10, left: 50, bottom: 20, right: 45))
    }
}


