//
//  DetailViewController.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 07.01.2021.
//

import UIKit

@available(iOS 13.0, *)
final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        innerView.layer.cornerRadius = 15
    }
    
}
