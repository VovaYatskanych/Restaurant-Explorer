//
//  Response.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 05.01.2021.
//

import Foundation

public struct Response: Codable {
    public let results_found: Int
    public let restaurants: [Restaurants]
}

public struct Restaurants: Codable {
    public let restaurant: Restaurant
}

public struct Restaurant: Codable {
    public let id: String
    public let name: String
    public let url: String
    public let featured_image: String
    public let phone_numbers: String
    public let average_cost_for_two: Int
    public let location: Location
    public let user_rating: UserRating
}

public struct Location: Codable {
    public let address: String
}

public struct UserRating: Codable {
    public let rating_obj: RatingObj
}

public struct RatingObj: Codable {
    public let title: Title
}

public struct Title: Codable {
    public let text: String
}

