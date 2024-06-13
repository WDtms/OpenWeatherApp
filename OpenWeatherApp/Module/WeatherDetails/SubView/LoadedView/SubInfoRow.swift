//
//  SubInfoRow.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class SubInfoRow: UIView {

    private let timeItem: SubInfoRowItem        = SubInfoRowItem()
    private let humItem: SubInfoRowItem         = SubInfoRowItem()
    private let feelsLikeItem: SubInfoRowItem   = SubInfoRowItem()
    private let speedItem: SubInfoRowItem       = SubInfoRowItem()
    
    private var timer: Timer?
    private var timeOffset: TimeInterval?
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(details: CurrentWeatherDetails, weatherDateInfo: WeatherDateInfo) {
        humItem.configure(title:  NSLocalizedString("humidity_title", comment: "").uppercased(), subtitle: "\(String(details.humidity))%")
        feelsLikeItem.configure(title: NSLocalizedString("feels_like_title", comment: "").uppercased(), subtitle: "\(details.tempFeelsLike)°C")
        speedItem.configure(title: NSLocalizedString("wind_title", comment: "").uppercased(), subtitle: "\(details.windSpeed) km/h")
        timeItem.configure(title:  NSLocalizedString("time_title", comment: "").uppercased(), subtitle: DateUtils.getHHMMformattedDate(date: weatherDateInfo.currentDate))
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                             = .secondarySystemBackground
        layer.cornerRadius                          = 11
        
        configureStackView()
    }
    
    private func configureStackView() {
        let stackView                                       = UIStackView(arrangedSubviews: [timeItem, humItem, feelsLikeItem, speedItem])
        stackView.axis                                      = .horizontal
        stackView.distribution                              = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
