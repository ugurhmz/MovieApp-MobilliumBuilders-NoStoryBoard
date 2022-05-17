//
//  HomeTopCellModel.swift
//  MovieCase
//
//  Created by ugur-pc on 17.05.2022.
//

import UIKit

protocol HomeTopCellDataSource: AnyObject {
    var homeTopCellArr: [HomeSliderCellProtocol] { get set}
}

protocol HomeTopCellEventSource: AnyObject { }

protocol HomeTopCellProtocol: HomeTopCellDataSource, HomeTopCellEventSource {
    func numberofItemsAtSection(section: Int) -> Int
    func cellForItem(indexPath: IndexPath) -> HomeSliderCellProtocol
    var numberOfItems: Int {get }
}


//MARK: - CellModel
final class HomeTopCellModel: HomeTopCellProtocol {
    var homeTopCellArr: [HomeSliderCellProtocol] = []
    
    var numberOfItems: Int {
           return homeTopCellArr.count
    }
    
    init(homeHeaderCellValues: [HomeSliderCellProtocol]){
        self.homeTopCellArr = homeHeaderCellValues
    }
    
    func numberofItemsAtSection(section: Int) -> Int {
        return homeTopCellArr.count
    }
    
    func cellForItem(indexPath: IndexPath) -> HomeSliderCellProtocol {
        return homeTopCellArr[indexPath.row]
    }
    
}
