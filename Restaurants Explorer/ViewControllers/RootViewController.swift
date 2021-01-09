//
//  ViewController.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 05.01.2021.
//

import UIKit
import SafariServices

@available(iOS 13.0, *)
final class RootViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    
    var latitude: String?
    var longitute: String?
    var response: Response?
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupGesture()
        fetchData(sortBy: .none)
        LocationManager.shared.setLocation()
    }
    
    private func setupViewController(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .orange
        view.backgroundColor = .orange
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        sortButton.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func tapped() {
        guard let sortViewController = storyboard?.instantiateViewController(identifier: "SortVIewController") as? SortTableViewController else { return }
        sortViewController.modalPresentationStyle = .popover
        let popOverViewController = sortViewController.popoverPresentationController
        popOverViewController?.delegate = self
        popOverViewController?.sourceView = self.sortButton
        popOverViewController?.sourceRect = CGRect( x: self.sortButton.bounds.minX,
                                                    y: self.sortButton.bounds.maxY, width: 0, height: 0)
        sortViewController.preferredContentSize = CGSize(width: 250, height: 250)
        sortViewController.delegate = self
        self.present(sortViewController, animated: true)
    }
}

//MARK: - Extensions

@available(iOS 13.0, *)
extension RootViewController: UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.restaurants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantCell
        cell.setTitleLabel((response?.restaurants[indexPath.row].restaurant.name)!)
        cell.setRatingLabel("Rating: \(String(describing: (self.response?.restaurants[indexPath.row].restaurant.user_rating.rating_obj.title.text)!)) ")
        let imageURL: String = (self.response?.restaurants[indexPath.row].restaurant.featured_image)!
        let defUrl = URL(string: "https://www.holidify.com/images/cmsuploads/compressed/indian-1768906_1920_20180322173733.jpg")!
        let url = URL(string: imageURL)
        if let data = try? Data(contentsOf: url ?? defUrl) {
            cell.setRestaurantImage(UIImage(data: data)!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = (storyboard?.instantiateViewController(identifier: "detailViewController"))! as DetailViewController
        
        var request = URLRequest(url: UrlConfiguration.getUrl(sortBy: .restaurant, id: response?.restaurants[indexPath.row].restaurant.id, lat: "", lon: "" ))
        
        request.httpMethod = "GET"
        request.addValue("e87ffa5ef29978595809c1967d29814a", forHTTPHeaderField: "user-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if data != nil {
                    do {
                        let response = try JSONDecoder().decode(Restaurant.self, from: data!)
                        DispatchQueue.main.async {
                            detailViewController.nameLabel.text = response.name
                            detailViewController.ratingLabel.text = "Rating: \(response.user_rating.rating_obj.title.text)"
                            detailViewController.costLabel.text = "Avarage cost for two: \(response.average_cost_for_two)$"
                            detailViewController.phoneLabel.text = "Phone number: \(response.phone_numbers)"
                            detailViewController.addressLabel.text = "Address: \(response.location.address)"
                        }
                    } catch let error {
                        print(error as Any)
                    }
                }
            }
        }.resume()
        present(detailViewController, animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)
extension RootViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

@available(iOS 13.0, *)
extension RootViewController: FilterDelegate {
    
    func getLocation() {
        LocationManager.shared.getLocation { (lat, lon) in
            self.latitude = String(lat!)
            self.longitute = String(lon!)
        }
    }
    
    func fetchData(sortBy sort: SortBy) {
        NetworkManager.shared.getRestaurants(sortBy: sort, id: "", lat: latitude, lon: longitute){ (response) in
            self.response = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
