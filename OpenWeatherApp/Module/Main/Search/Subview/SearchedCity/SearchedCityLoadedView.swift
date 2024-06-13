//
//  SearchedCityLoadedView.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 13.06.2024.
//

import UIKit

class SearchedCityLoadedView: UIView {
    
    private let cityNameLabel: UILabel          = UILabel()
    private let cityCurrentTempLabel: UILabel   = UILabel()
    private let weatherImage: UIImageView       = UIImageView()
    private let weatherWarningLabel: UILabel    = UILabel()
    private let warningLabel: UILabel           = UILabel()
    private let warningIconView: UIImageView    = UIImageView()
    private let currentTimeLabel: UILabel       = UILabel()
    
    private var usualWeatherPath: String?

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(details: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo) {
        cityNameLabel.text          = details.name
        cityCurrentTempLabel.text   = "\(details.temp)°"
        currentTimeLabel.text       = DateUtils.getHHMMformattedDate(date: weatherDateInfo.currentDate)
        
        if usualWeatherPath == nil {
            weatherImage.image          = UIImage(named: details.imagePath)
            usualWeatherPath = details.imagePath
        }
    }
    
    func configure(expectedBadWeather: ExpectedBadWeatherViewModel) {
        switch expectedBadWeather {
            
        case .rain(iconPath: let iconPath, _):
            warningIconView.image       = UIImage(systemName: "exclamationmark.triangle")
            weatherWarningLabel.text    = NSLocalizedString("expecting_rainfall_title", comment: "")
            weatherImage.image          = UIImage(named: iconPath)
            warningLabel.text           = NSLocalizedString("warning_title", comment: "").uppercased()
        case .snow(iconPath: let iconPath, _):
            warningIconView.image       = UIImage(systemName: "exclamationmark.triangle")
            weatherWarningLabel.text    = NSLocalizedString("expecting_snowfall_title", comment: "")
            weatherImage.image          = UIImage(named: iconPath)
            warningLabel.text           = NSLocalizedString("warning_title", comment: "").uppercased()
        case .none:
            warningIconView.image       = nil
            weatherWarningLabel.text    = nil
            warningLabel.text           = nil
            
            if let usualWeatherPath {
                weatherImage.image = UIImage(named: usualWeatherPath)
            }
        }
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureCityNameLabel()
        configureCurrentTimeLabel()
        configureCityCurrentTempLabel()
        configureWarningImageView()
        configureWarningLabel()
        configureWeatherWarningLabel()
        configureWeatherImage()
    }
    
    private func configureCityNameLabel() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font                                      = .systemFont(ofSize: 20, weight: .semibold)
        cityNameLabel.textColor                                 = .label
        
        addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
        ])
    }
    
    private func configureCurrentTimeLabel() {
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints  = false
        currentTimeLabel.font                                       = .systemFont(ofSize: 14, weight: .semibold)
        currentTimeLabel.textColor                                  = .systemGray
        
        addSubview(currentTimeLabel)
        
        NSLayoutConstraint.activate([
            currentTimeLabel.leadingAnchor.constraint(equalTo: cityNameLabel.leadingAnchor),
            currentTimeLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 6),
        ])
    }
    
    private func configureCityCurrentTempLabel() {
        cityCurrentTempLabel.translatesAutoresizingMaskIntoConstraints  = false
        cityCurrentTempLabel.font                                       = .systemFont(ofSize: 60, weight: .medium)
        cityCurrentTempLabel.textColor                                  = .label
        
        addSubview(cityCurrentTempLabel)
        
        NSLayoutConstraint.activate([
            cityCurrentTempLabel.leadingAnchor.constraint(equalTo: currentTimeLabel.leadingAnchor),
            cityCurrentTempLabel.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 2),
        ])
    }
    
    private func configureWeatherImage() {
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherImage)
        
        NSLayoutConstraint.activate([
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weatherImage.bottomAnchor.constraint(equalTo: weatherWarningLabel.topAnchor, constant: -10),
            weatherImage.widthAnchor.constraint(equalToConstant: 130),
            weatherImage.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
    
    private func configureWarningImageView() {
        warningIconView.translatesAutoresizingMaskIntoConstraints   = false
        warningIconView.tintColor                                   = .systemYellow
        
        addSubview(warningIconView)
        
        NSLayoutConstraint.activate([
            warningIconView.leadingAnchor.constraint(equalTo:  cityNameLabel.leadingAnchor),
            warningIconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            warningIconView.heightAnchor.constraint(equalToConstant: 14),
            warningIconView.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
    
    private func configureWarningLabel() {
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.font                                      = .systemFont(ofSize: 15)
        warningLabel.textColor                                 = .systemYellow
        
        addSubview(warningLabel)
        
        NSLayoutConstraint.activate([
            warningLabel.bottomAnchor.constraint(equalTo: warningIconView.bottomAnchor),
            warningLabel.leadingAnchor.constraint(equalTo: warningIconView.trailingAnchor, constant: 8),
        ])
    }
    
    private func configureWeatherWarningLabel() {
        weatherWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherWarningLabel.font                                      = .systemFont(ofSize: 15)
        weatherWarningLabel.textColor                                 = .systemYellow
        
        addSubview(weatherWarningLabel)
        
        NSLayoutConstraint.activate([
            weatherWarningLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            weatherWarningLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
