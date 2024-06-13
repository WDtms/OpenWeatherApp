//
//  SearchedCollectionViewCell.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import UIKit

class SearchedCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchedCollectionViewCell"
    
    private let horizontalPadding: CGFloat          = 20
    private let secondaryVerticalPadding: CGFloat   = 10
    
    private let containerView: UIView       = UIView()
    private let cityNameLabel: UILabel      = UILabel()
    
    private var longitudeLabel: UILabel     = UILabel()
    private var latitudeLabel: UILabel      = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(with city: CityViewModel) {
        cityNameLabel.text = city.name
        longitudeLabel.text = "\(NSLocalizedString("longitude_title", comment: "")): \(city.longitude)"
        latitudeLabel.text = "\(NSLocalizedString("latitude_title", comment: "")): \(city.latitude)"
    }
    
    private func setupUI() {
        configureWrappingContainer()
        configureCityNameLabel()
        configureLongitudeLabel()
        configureLatitudeLabel()
    }
    
    private func configureWrappingContainer() {
        containerView.backgroundColor                            = .secondarySystemBackground
        containerView.translatesAutoresizingMaskIntoConstraints  = false
        containerView.layer.cornerRadius                         = 12
        
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
        ])
    }
    
    private func configureCityNameLabel() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font                                      = .boldSystemFont(ofSize: 24)
        cityNameLabel.textColor                                 = .label
        
        contentView.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalPadding),
        ])
    }
    
    private func configureLatitudeLabel() {
        createCoordinateLabel(label: &latitudeLabel)
        
        contentView.addSubview(latitudeLabel)
        
        NSLayoutConstraint.activate([
            latitudeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -horizontalPadding),
            latitudeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -secondaryVerticalPadding),
        ])
    }
    
    private func configureLongitudeLabel() {
        createCoordinateLabel(label: &longitudeLabel)
        
        contentView.addSubview(longitudeLabel)
        
        NSLayoutConstraint.activate([
            longitudeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -horizontalPadding),
            longitudeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: secondaryVerticalPadding),
        ])
    }
    
    private func createCoordinateLabel(label: inout UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = .systemFont(ofSize: 12)
        label.textColor                                 = .systemGray2
        label.textAlignment                             = .right
    }
}

