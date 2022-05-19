//
//  HomeDetailVC.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import UIKit
import MobilliumBuilders
import Kingfisher

class HomeDetailVC: BaseViewController<HomeDetailViewModel>  {
    
    private let navigationBar : UINavigationBar = {
            let navBar = UINavigationBar()
            let navigationItem =  UINavigationItem()
            let button = UIBarButtonItem()
            let standardAppearance = UINavigationBarAppearance()
            standardAppearance.configureWithOpaqueBackground()
            standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            standardAppearance.backgroundColor = .clear
            navigationItem.standardAppearance = standardAppearance
            navigationItem.scrollEdgeAppearance = standardAppearance
            navigationItem.compactAppearance = standardAppearance
            
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black,.font : UIFont.systemFont(ofSize:23, weight: .bold)]
            button.tintColor = .systemBlue
            navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
            navigationItem.compactAppearance?.buttonAppearance = buttonAppearance
            
            button.image = UIImage(systemName: "chevron.left")
            button.action = #selector(backToHomePageBtn)
            navBar.layer.zPosition = 1
            navigationItem.leftBarButtonItem = button
            navBar.setItems([navigationItem], animated: false)
            return navBar
    }()
    
    
    private var generalCollectionView: UICollectionView = {
               let layout = UICollectionViewFlowLayout()
               let cv = UICollectionView(frame: .zero, collectionViewLayout: HomeDetailVC.createCompositionalLayout())
               cv.backgroundColor = .white
               cv.translatesAutoresizingMaskIntoConstraints = false
               
               // register
               cv.register(UICollectionViewCell.self,
                           forCellWithReuseIdentifier: "cellId")
              //titlte
               cv.register(HeaderReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier:   HeaderReusableView.identifier)
               // cell
               cv.register(SimilarMovieCollectionCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionCell.identifier)
               return cv
      }()
       
       //MARK: - createCompositionalLayout
         static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
             let mylayout = UICollectionViewCompositionalLayout {  (index, environment) -> NSCollectionLayoutSection? in
                
                 return  HomeDetailVC.createSectionFor(index: index, environment: environment)
              }
              
              return mylayout
          }
       
       static func createSectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
              
              switch index {
              case 0:
                  return createSecondSection()
            
              default:
                  return  createSecondSection()
              }
          }
       
       //MARK: - SECOND SECTION
        static func createSecondSection() -> NSCollectionLayoutSection {
            
            let inset: CGFloat = 2
            
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                  heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                         leading: inset,
                                                         bottom: inset,
                                                         trailing: inset)
            
            // group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.62),
                                                   heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem:  item, count: 2)
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            
            // suplementary
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(25))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: "header",
                                                                     alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
    
    
    private let movieImgView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .build()
    
    private let imdbImageIcon = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .build()
    
    private let starIcon = UIImageViewBuilder()
        .contentMode(.scaleAspectFit)
        .tintColor(.systemYellow)
        .build()
    
    private let rateLabel = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .medium))
        .textColor(.black)
        .build()
    
    private let circleIcon = UIImageViewBuilder()
        .contentMode(.scaleAspectFit)
        .tintColor(.systemYellow)
        .build()
    
    private let releaseDatelabel = UILabelBuilder()
        .font(.systemFont(ofSize: 15, weight: .medium))
        .textColor(.black)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .font(.systemFont(ofSize: 23, weight: .bold))
        .textColor(.black)
        .numberOfLines(2)
        .build()
    
    private let overviewLbl = UILabelBuilder()
        .font(.systemFont(ofSize: 17, weight: .regular))
        .textColor(.black)
        .numberOfLines(0)
        .build()
    
    private let descriptionText = UITextViewBuilder()
        .font(.systemFont(ofSize: 16))
        .textAlignment(.left)
        .isEditable(false)
        .textColor(.black)
        .build()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        generalCollectionView.dataSource = self
               generalCollectionView.delegate = self
                      
               generalCollectionView.collectionViewLayout =  HomeDetailVC.createCompositionalLayout()
        
        generalCollectionView.layer.zPosition = 1
        
        setupViews()
        setConstraints()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchDetailData()
        viewModel.fetchSimilarMovieData()
    }
    
    
}
//MARK: - Delegate,DataSource
extension HomeDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
  
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
      func collectionView(_ collectionView: UICollectionView,
                          numberOfItemsInSection section: Int) -> Int {
          return self.viewModel.numberItemsInSection
      }
   
        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                                 for: indexPath)
            
            if indexPath.section == 0 {
                let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionCell.identifier, for: indexPath) as! SimilarMovieCollectionCell
              
                
                if let similarList = self.viewModel.similarMovieArr {
                    cell.fillSimilarData(movieValue: similarList[indexPath.row])
                }
                
                return cell
            }
            
            return cell
        }
   
     func collectionView(_ collectionView: UICollectionView,
                         viewForSupplementaryElementOfKind kind: String,
                         at indexPath: IndexPath) -> UICollectionReusableView {
         
         let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as! HeaderReusableView
         
         if indexPath.section == 0 {
             view.titleLabel.text = viewModel.headerSection
         }
         
         return view
     }
   
    
}


//MARK: - Fill Data
extension HomeDetailVC {
    private func fillData(){
        
        if let mvTitle = viewModel.movieTitle {
            if let movieDate = viewModel.movieReleaseData {
                self.titleLabel.text = "\(mvTitle) (\(movieDate.prefix(4)))"
            }
        }
        self.descriptionText.text = viewModel.movieDefinition
        self.movieImgView.kf.setImage(with: viewModel.movieImageUrl)
        if let mvRate = viewModel.movieRate {
                   self.rateLabel.text = "\(mvRate)/10"
                   self.rateLabel.colorString(text: "\(mvRate)/10", coloredText: "/10")
        }
        self.releaseDatelabel.text = viewModel.movieReleaseData
        starIcon.image = UIImage(systemName: "star.fill")
        imdbImageIcon.image = UIImage(named:"imdbIcon")
        circleIcon.image = UIImage(systemName: "circle.fill")
    }
}


//MARK: - Constraints & setup
extension HomeDetailVC {
    private func setupViews(){
        [generalCollectionView,navigationBar,movieImgView,imdbImageIcon,starIcon,circleIcon,rateLabel,releaseDatelabel].forEach{ view.addSubview($0)}
        view.addSubview(titleLabel)
        view.addSubview(descriptionText)
        self.hideActivityIndicator()
       
        viewModel.reloadData = { [weak self] in
            guard let strongSelf = self else { return }
            self?.fillData()
            strongSelf.generalCollectionView.reloadData()
        }
    }
    
    @objc func backToHomePageBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setConstraints(){
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                    leading: view.leadingAnchor,
                                    bottom: nil,
                                    trailing: view.trailingAnchor)
        movieImgView.anchor(top: view.topAnchor,
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
        descriptionText.anchor(top: titleLabel.bottomAnchor,
                       leading: view.leadingAnchor,
                               bottom: generalCollectionView.topAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 3,
                                       left: 15, bottom: 0, right: 15))
        
        generalCollectionView.anchor(top: nil,
                                            leading: view.leadingAnchor,
                                            bottom: view.bottomAnchor,
                                            trailing: view.trailingAnchor,
                                            padding: .init(top: 0,
                                                            left: 5, bottom: 15, right: 0),
                                            size: .init(width: 0, height: 220))
    }
}
