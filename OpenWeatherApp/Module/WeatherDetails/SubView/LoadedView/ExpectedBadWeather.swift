//
//  ExpectedBadWeather.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import UIKit

class ExpectedBadWeather: UIView {
    
    private let warningTitleLabel: UILabel          = UILabel()
    private let warningIconView: UIImageView        = UIImageView()
    private let weatherLabeL: UILabel               = UILabel()
    private let weatherIconView: UIImageView        = UIImageView()
    private let weatherExpTimeTitleLabel: UILabel   = UILabel()
    private let weatherExpTimeValueLabel: UILabel   = UILabel()

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    func configure(with expectedWeather: ExpectedBadWeatherViewModel) {
        switch expectedWeather {
        case .rain(iconPath: let iconPath, let date):
            weatherIconView.image           = UIImage(named: iconPath)
            weatherLabeL.text               = NSLocalizedString("expecting_rainfall_title", comment: "")
            weatherExpTimeValueLabel.text   = DateUtils.getHHMMformattedDate(date: date)
            
        case .snow(iconPath: let iconPath, let date):
            weatherIconView.image           = UIImage(named: iconPath)
            weatherLabeL.text               = NSLocalizedString("expecting_snowfall_title", comment: "")
            weatherExpTimeValueLabel.text   = DateUtils.getHHMMformattedDate(date: date)
            
        case .none:
            return
        }
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                             = .secondarySystemBackground
        layer.cornerRadius                          = 11
        
        configureWarningIconView()
        configureTitleLabel()
        configureWeatherImageView()
        configureWeatherLabel()
        configureWeatherExpTimeTitleLabel()
        configureWeatherExpTemeValueLabel()
    }
    
    private func configureWarningIconView() {
        warningIconView.translatesAutoresizingMaskIntoConstraints   = false
        warningIconView.image                                       = UIImage(systemName: "exclamationmark.triangle")
        warningIconView.tintColor                                   = .systemYellow
        
        addSubview(warningIconView)
        
        NSLayoutConstraint.activate([
            warningIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            warningIconView.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            warningIconView.heightAnchor.constraint(equalToConstant: 14),
            warningIconView.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
    
    private func configureTitleLabel() {
        warningTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        warningTitleLabel.font                                      = .systemFont(ofSize: 15)
        warningTitleLabel.textColor                                 = .systemYellow
        warningTitleLabel.text                                      = NSLocalizedString("warning_title", comment: "").uppercased()
        
        addSubview(warningTitleLabel)
        
        NSLayoutConstraint.activate([
            warningTitleLabel.leadingAnchor.constraint(equalTo: warningIconView.trailingAnchor, constant: 9),
            warningTitleLabel.topAnchor.constraint(equalTo: warningIconView.topAnchor)
        ])
    }
    
    private func configureWeatherImageView() {
        weatherIconView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherIconView)
        
        NSLayoutConstraint.activate([
            weatherIconView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            weatherIconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            weatherIconView.heightAnchor.constraint(equalToConstant: 120),
            weatherIconView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func configureWeatherLabel() {
        weatherLabeL.translatesAutoresizingMaskIntoConstraints = false
        weatherLabeL.font                                      = .systemFont(ofSize: 15)
        weatherLabeL.textColor                                 = .systemYellow

        addSubview(weatherLabeL)
        
        NSLayoutConstraint.activate([
            weatherLabeL.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            weatherLabeL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    private func configureWeatherExpTimeTitleLabel() {
        weatherExpTimeTitleLabel.translatesAutoresizingMaskIntoConstraints  = false
        weatherExpTimeTitleLabel.text                                       = NSLocalizedString("expected_time_title", comment: "")
        weatherExpTimeTitleLabel.font                                       = .systemFont(ofSize: 14, weight: .medium)
        weatherExpTimeTitleLabel.textColor                                  = .systemGray2
        
        addSubview(weatherExpTimeTitleLabel)
        
        NSLayoutConstraint.activate([
            weatherExpTimeTitleLabel.topAnchor.constraint(equalTo: warningTitleLabel.bottomAnchor, constant: 24),
            weatherExpTimeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    
    private func configureWeatherExpTemeValueLabel() {
        weatherExpTimeValueLabel.translatesAutoresizingMaskIntoConstraints  = false
        weatherExpTimeValueLabel.font                                       = .systemFont(ofSize: 20, weight: .medium)
        weatherExpTimeValueLabel.textColor                                  = .systemGray
        
        addSubview(weatherExpTimeValueLabel)
        
        NSLayoutConstraint.activate([
            weatherExpTimeValueLabel.topAnchor.constraint(equalTo: weatherExpTimeTitleLabel.bottomAnchor, constant: 12),
            weatherExpTimeValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
}
