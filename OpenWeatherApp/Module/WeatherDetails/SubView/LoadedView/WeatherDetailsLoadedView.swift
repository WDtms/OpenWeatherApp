//
//  WeatherDetailsLoadedView.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class WeatherDetailsLoadedView: UIView {
    
    private let weatherImage: UIImageView   = UIImageView()
    private let cityNameLabel: UILabel      = UILabel()
    private let locationImage: UIImageView  = UIImageView()
    private let currentTempLabel: UILabel   = UILabel()

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        setupUI()
    }
    
    func configure(with details: CurrentWeatherDetails) {
        weatherImage.image      = UIImage(named: details.imagePath)
        cityNameLabel.text      = details.name
        currentTempLabel.text   = "\(details.temp)°"
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureImage()
        configureCityNameLabel()
        configureLocationImage()
        configureCurrentTempLabel()
    }
    
    private func configureImage() {
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherImage)
        
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 200),
            weatherImage.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureCityNameLabel() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font                                      = .systemFont(ofSize: 30, weight: .semibold)
        cityNameLabel.textColor                                 = .label
        
        addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 20),
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureLocationImage() {
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationImage.image                                     = UIImage(systemName: "location.fill")
        locationImage.tintColor                                 = .black
        
        addSubview(locationImage)
        
        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: 10),
            locationImage.bottomAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: -2),
            locationImage.widthAnchor.constraint(equalToConstant: 30),
            locationImage.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func configureCurrentTempLabel() {
        currentTempLabel.translatesAutoresizingMaskIntoConstraints  = false
        currentTempLabel.font                                       = .systemFont(ofSize: 70, weight: .bold)
        currentTempLabel.textColor                                  = .label
        
        addSubview(currentTempLabel)
        
        NSLayoutConstraint.activate([
            currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentTempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 16),
        ])
    }
}
