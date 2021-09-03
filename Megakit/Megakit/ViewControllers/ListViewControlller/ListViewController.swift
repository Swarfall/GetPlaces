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
    private var cityViewModels: [CityViewModel] = []
    
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
    
    func fetchTemperature(results: [CityViewModel]) {
        
        let dispatchGroup = DispatchGroup()
        
        for (index, city) in results.enumerated() {
            dispatchGroup.enter()
            
            Requests.getTemperature(lat: "\(city.lat)", long: "\(city.long)") { [weak self] temperature in
                guard let self = self else { return }
                
                self.cityViewModels[index].temperature = temperature?.main.temp
                
                dispatchGroup.leave()
                
            } failure: { [weak self] error in
                self?.showAlert(title: CustomError.defaultError.failureReason,
                                message: error?.localizedDescription)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            self.listTableViewAdapter.update(self.cityViewModels)
            self.rootView.tableView.reloadData()
            self.hideLoader()
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
                guard let self = self else { return}
                
                for city in result.results {
                    self.cityViewModels.append(CityViewModel(name: city.formattedAddress, lat: city.geometry.location.lat, long: city.geometry.location.lng))
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return}
                    
                    self.listTableViewAdapter.update(self.cityViewModels)
                    self.rootView.tableView.reloadData()
                    self.fetchTemperature(results: self.cityViewModels)
                    
                    Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
                        guard let self = self else { return }
                        
                        self.fetchTemperature(results: self.cityViewModels)
                    }
                }
                
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
