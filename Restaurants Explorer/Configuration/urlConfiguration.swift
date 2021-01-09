//
//  urlConfiguration.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 05.01.2021.
//

import Foundation

enum SortBy: String {
    
    case cost = "cost"
    case rating = "rating"
    case distance = "real_distance"
    case restaurant
    case none
}

@available(iOS 13.0, *)
struct UrlConfiguration {
    
    static func getUrl(sortBy sort: SortBy, id: String?,  lat: String?, lon: String?) -> URL {
        
        switch sort {
        case .cost, .rating:
            var components = URLComponents()
            components.scheme = "http"
            components.host = "developers.zomato.com"
            components.path = "/api/v2.1/search"
            let sort = URLQueryItem(name: "sort", value: sort.rawValue)
            components.queryItems = [sort]
            return components.url!
        case .distance:
            var components = URLComponents()
            components.scheme = "http"
            components.host = "developers.zomato.com"
            components.path = "/api/v2.1/search"
            let lat = URLQueryItem(name: "lat", value: lat!)
            let lon = URLQueryItem(name: "lon", value: lon!)
            let sort = URLQueryItem(name: "sort", value: sort.rawValue)
            components.queryItems = [lat, lon, sort]
            return components.url!
        case .restaurant:
            var components = URLComponents()
            components.scheme = "http"
            components.host = "developers.zomato.com"
            components.path = "/api/v2.1/restaurant"
            let id = URLQueryItem(name: "res_id", value: id)
            components.queryItems = [id]
            return components.url!
        case .none:
            var components = URLComponents()
            components.scheme = "http"
            components.host = "developers.zomato.com"
            components.path = "/api/v2.1/search"
            return components.url!
        }
    }
}
