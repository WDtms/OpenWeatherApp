//
//  WeatherDetailsLoadedView.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class WeatherDetailsLoadedView: UIView {
    
    private let idxOfExpectedBadWeather = 6
    
    private let weatherImage: UIImageView               = UIImageView()
    private let cityNameLabel: UILabel                  = UILabel()
    private let locationImage: UIImageView              = UIImageView()
    private let currentTempLabel: UILabel               = UILabel()
    private let weatherSubInfoRow: SubInfoRow           = SubInfoRow()
    private let sunriseGraphView: SunriseGraphView      = SunriseGraphView()
    private let stackView: UIStackView                  = UIStackView()
    private let scrollView: UIScrollView                = UIScrollView()
    private var expectedBadWeather: ExpectedBadWeather  = ExpectedBadWeather()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(details: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo) {
        weatherImage.image      = UIImage(named: details.imagePath)
        cityNameLabel.text      = details.name
        currentTempLabel.text   = "\(details.temp)°"
        
        weatherSubInfoRow.configure(details: details, weatherDateInfo: weatherDateInfo)
        sunriseGraphView.configure(with: weatherDateInfo)
    }
    
    func handleExpectedBadWeather(with expectedBadWeatherViewModel: ExpectedBadWeatherViewModel) {
        switch expectedBadWeatherViewModel {
        case .rain(_, _):
            insertAndConfigureExpectedBadWeather(with: expectedBadWeatherViewModel)
        case .snow(_, _):
            insertAndConfigureExpectedBadWeather(with: expectedBadWeatherViewModel)
        case .none:
            removeExpectedBadWeatherFromStackView()
        }
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureScrollView()
        configureStackView()
        configureImage()
        configureCityNameLabel()
        configureCurrentTempLabel()
        configureSubInfoRow()
        configureSunrizeGraphView()
        configureLocationImage()
        
        addSpacing(height: 30)
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints    = false
        scrollView.showsVerticalScrollIndicator                 = false
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis                                      = .vertical
        stackView.alignment                                 = .center
        stackView.spacing                                   = 11
        
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureImage() {
        let wrapperView = UIView()
        wrapperView.layer.cornerRadius  = 110
        wrapperView.backgroundColor     = .secondarySystemBackground
        wrapperView.layer.masksToBounds = true
        
        wrapperView.translatesAutoresizingMaskIntoConstraints   = false
        weatherImage.translatesAutoresizingMaskIntoConstraints  = false
        
        addSpacing(height: 10)
        stackView.addArrangedSubview(wrapperView)
        
        wrapperView.addSubview(weatherImage)
        
        NSLayoutConstraint.activate([
            wrapperView.widthAnchor.constraint(equalToConstant: 220),
            wrapperView.heightAnchor.constraint(equalToConstant: 220),
            
            weatherImage.widthAnchor.constraint(equalToConstant: 200),
            weatherImage.heightAnchor.constraint(equalToConstant: 200),
            weatherImage.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
        ])
    }
    
    private func configureCityNameLabel() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font                                      = .systemFont(ofSize: 30, weight: .semibold)
        cityNameLabel.textColor                                 = .label
        
        addSpacing(height: 10)
        stackView.addArrangedSubview(cityNameLabel)
    }
    
    private func configureCurrentTempLabel() {
        currentTempLabel.translatesAutoresizingMaskIntoConstraints  = false
        currentTempLabel.font                                       = .systemFont(ofSize: 70, weight: .bold)
        currentTempLabel.textColor                                  = .label
        
        addSpacing(height: 6)
        stackView.addArrangedSubview(currentTempLabel)
    }
    
    private func configureSubInfoRow() {
        stackView.addArrangedSubview(weatherSubInfoRow)
        
        NSLayoutConstraint.activate([
            weatherSubInfoRow.heightAnchor.constraint(equalToConstant: 59),
            weatherSubInfoRow.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            weatherSubInfoRow.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
    
    private func configureSunrizeGraphView() {
        stackView.addArrangedSubview(sunriseGraphView)
        
        NSLayoutConstraint.activate([
            sunriseGraphView.heightAnchor.constraint(equalToConstant: 229),
            sunriseGraphView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            sunriseGraphView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
    
    private func configureLocationImage() {
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationImage.image                                     = UIImage(systemName: "location.fill")
        locationImage.tintColor                                 = .label

        addSubview(locationImage)

        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: 10),
            locationImage.bottomAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: -2),
            locationImage.widthAnchor.constraint(equalToConstant: 30),
            locationImage.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func insertAndConfigureExpectedBadWeather(with expectedBadWeatherViewModel: ExpectedBadWeatherViewModel) {
        expectedBadWeather.configure(with: expectedBadWeatherViewModel)
        
        if !stackView.contains(expectedBadWeather) {
            stackView.insertArrangedSubview(expectedBadWeather, at: idxOfExpectedBadWeather)
            
            NSLayoutConstraint.activate([
                expectedBadWeather.heightAnchor.constraint(equalToConstant: 163),
                expectedBadWeather.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                expectedBadWeather.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            ])
        }
    }
    
    private func removeExpectedBadWeatherFromStackView() {
        if stackView.contains(expectedBadWeather) {
            stackView.removeArrangedSubview(expectedBadWeather)
            
            expectedBadWeather.removeFromSuperview()
        }
    }
    
    private func addSpacing(height: CGFloat) {
        let spacer                                          = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints    = false
        
        stackView.addArrangedSubview(spacer)
        
        NSLayoutConstraint.activate([
            spacer.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
