//
//  RestaurantCell.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 05.01.2021.
//

import UIKit

final class RestaurantCell: UITableViewCell {
    
    //MARK: - Properties

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLable: UILabel!
    @IBOutlet private weak var restaurantImage: UIImageView!
    
    //MARK: - Functions
    
    func setTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setRatingLabel(_ rating: String) {
        self.ratingLable.text = rating
    }
    
    func setRestaurantImage(_ image: UIImage) {
        self.restaurantImage.image = image
    }
}
