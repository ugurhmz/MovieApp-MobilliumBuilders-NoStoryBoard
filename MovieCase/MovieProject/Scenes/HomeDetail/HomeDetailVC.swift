//
//  HomeDetailVC.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import UIKit
import MobilliumBuilders

class HomeDetailVC: BaseViewController<HomeDetailViewModel>  {
   
    
    private let movieImgView = UIImageViewBuilder()
        .image(UIImage(named: "a5") ?? UIImage())
        .contentMode(.scaleToFill)
        .build()
    
    private let imdbImageIcon = UIImageViewBuilder()
        .image(UIImage(named: "imdbIcon") ?? UIImage())
        .contentMode(.scaleToFill)
        .build()
    
    private let starIcon = UIImageViewBuilder()
        .image(UIImage(systemName: "star.fill") ?? UIImage())
        .contentMode(.scaleAspectFit)
        .tintColor(.systemYellow)
        .build()
    
    private let rateLabel = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .medium))
        .text("7/10")
        .textColor(.black)
        .build()
    
    private let circleIcon = UIImageViewBuilder()
        .image(UIImage(systemName: "circle.fill") ?? UIImage())
        .contentMode(.scaleAspectFit)
        .tintColor(.systemYellow)
        .build()
    
    private let releaseDatelabel = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .medium))
        .text("26-04-1994")
        .textColor(.black)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .font(.systemFont(ofSize: 23, weight: .bold))
        .text("SpiderMan")
        .textColor(.black)
        .numberOfLines(2)
        .build()
    
    private let overviewLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 17, weight: .regular))
        .text("lorem ipsum")
        .textColor(.black)
        .numberOfLines(0)
        .build()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupViews()
        setConstraints()
        settingsNavigateBar()
    }
}

//MARK: -
extension HomeDetailVC {
    private func setupViews(){
        view.backgroundColor = .lightGray
        [movieImgView,imdbImageIcon,starIcon,circleIcon,rateLabel,releaseDatelabel].forEach{ view.addSubview($0)}
        view.addSubview(titleLabel)
        view.addSubview(overviewLbl)
    }
    
    private func settingsNavigateBar(){
        let button = UIBarButtonItem()
        let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black,.font : UIFont.systemFont(ofSize:26, weight: .bold)]
        button.tintColor = .systemBlue
        navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
        navigationItem.compactAppearance?.buttonAppearance = buttonAppearance
        button.image = UIImage(systemName: "chevron.left")
        button.action = #selector(backToHomePageBtn)

        navigationItem.leftBarButtonItem = button
    }
    
    @objc func backToHomePageBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setConstraints(){
        
        movieImgView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              size: .init(width: 0,
                                          height: 385))
        imdbImageIcon.anchor(top: movieImgView.bottomAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: nil,
                             padding: .init(top: 15, left: 15, bottom: 0, right: 0),
                             size: .init(width: 70,
                                         height: 34))

        starIcon.anchor(top: imdbImageIcon.topAnchor,
                        leading: imdbImageIcon.trailingAnchor,
                        bottom: nil,
                        trailing: nil,
                        padding: .init(top: 4,
                                       left: 15, bottom: 0, right: 0),
                        size: .init(width: 25,
                                    height: 25))
       rateLabel.anchor(top: starIcon.topAnchor,
                        leading: starIcon.trailingAnchor,
                        bottom: nil,
                        trailing: nil,
                        padding: .init(top: 0,
                                       left: 5, bottom: 0, right: 0),
                        size: .init(width: 50,
                                    height: 25))
        circleIcon.anchor(top: rateLabel.topAnchor,
                          leading: rateLabel.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          padding: .init(top: 8,
                                         left: 4, bottom: 0, right: 0),
                          size: .init(width: 8,
                                      height: 8))

        releaseDatelabel.anchor(top: starIcon.topAnchor,
                                 leading: circleIcon.trailingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: 0,
                                                left: 5, bottom: 0, right: 0),
                                 size: .init(width: 120,
                                             height: 25))

        titleLabel.anchor(top: imdbImageIcon.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: nil,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 6,
                                       left: 15, bottom: 0, right: 15),
                         size: .init(width: 0,
                                     height: 35))
        overviewLbl.anchor(top: titleLabel.bottomAnchor,
                       leading: view.leadingAnchor,
                        bottom: nil,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 3,
                                       left: 15, bottom: 0, right: 15))
    }
}
