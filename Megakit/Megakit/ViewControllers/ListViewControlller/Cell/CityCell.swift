//
//  CityCell.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import UIKit

final class CityCell: UITableViewCell {

    // MARK: - Private outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    // MARK: - Public property
    var model: CityViewModel? {
        didSet {
            configureUI()
        }
    }
}

// MARK: - Private
private extension CityCell {
    func configureUI() {
        nameLabel.text = nil
        temperatureLabel.text = nil
        
        if let model = model {
            nameLabel.text = model.name
            temperatureLabel.text = String(format: "%.0f", model.temperature - 273.15) + "°C"
        }
    }
}
