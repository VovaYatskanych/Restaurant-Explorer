//
//  FilterDelegate.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 06.01.2021.
//

import Foundation

protocol FilterDelegate: class {
    
    var latitude: String? { get }
    var longitute: String? { get }
    
    func getLocation()
    func fetchData(sortBy sort: SortBy)
}
