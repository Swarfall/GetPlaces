//
//  ListViewController.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import UIKit
import CoreLocation

final class ListViewController: BaseViewController {
    
    // MARK: - Private outlet
    @IBOutlet private weak var rootView: ListView!
    
    // MARK: - Private properties
    private let locationManager = CLLocationManager()
    private lazy var listTableViewAdapter = ListTableViewAdapter(tableView: rootView.tableView)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
    }
}

// MARK: - Private
private extension ListViewController {
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchTemperature(results: [Result]) {
        
        let dispatchGroup = DispatchGroup()
        
        var cityViewModels: [CityViewModel] = []
        
        for city in results {
            dispatchGroup.enter()
            
            Requests.getTemperature(lat: "\(city.geometry.location.lat)", long: "\(city.geometry.location.lng)") { temperature in

                cityViewModels.append(CityViewModel(name: city.formattedAddress,
                                                    temperature: temperature?.main.temp ?? 0.0))
                dispatchGroup.leave()
                
            } failure: { [weak self] error in
                self?.showAlert(title: CustomError.defaultError.failureReason,
                                message: error?.localizedDescription)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.listTableViewAdapter.update(cityViewModels)
            self?.rootView.tableView.reloadData()
            self?.hideLoader()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension ListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            locationManager.stopUpdatingLocation()
            showLoader()
            
            Requests.getPlaces(lat: "\(location.coordinate.latitude)",
                               long: "\(location.coordinate.longitude)") { [weak self] result in
                
                self?.fetchTemperature(results: result.results)
                
            } failure: { [weak self] error in
                self?.showAlert(title: CustomError.defaultError.failureReason,
                                message: error?.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        showAlert(title: "Error", message: error.localizedDescription)
    }
}
