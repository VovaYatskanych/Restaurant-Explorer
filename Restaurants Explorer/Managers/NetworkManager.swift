//
//  NetworkManager.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 05.01.2021.
//

import Foundation

@available(iOS 13.0, *)
final class NetworkManager {
    
    //MARK: - Properties

    private init(){ }
    static let shared: NetworkManager = NetworkManager()
    
    //MARK: - Functions

    func getRestaurants(sortBy sort: SortBy?, id: String, lat: String?, lon: String?, result: @escaping (Response?) -> Void) {
        
        var request = URLRequest(url: UrlConfiguration.getUrl(sortBy: sort!, id: id, lat: lat, lon: lon ))
        request.httpMethod = "GET"
        request.addValue("e87ffa5ef29978595809c1967d29814a", forHTTPHeaderField: "user-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if data != nil {
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: data!)
                        result(response)
                    } catch let error {
                        print(error as Any)
                    }
                }
            }
        }.resume()
    }
}
