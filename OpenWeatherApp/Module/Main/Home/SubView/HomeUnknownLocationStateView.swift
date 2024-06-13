//
//  UknownLocationStateView.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

protocol UnknownLocationStateDelegate {
    func askLocationPermission()
}

class HomeUnknownLocationStateView: UIView {

    let horizontalPadding: CGFloat = 32
    
    let messageLabel: UILabel = UILabel()
    let requestLocationButton = BaseButton()
    
    var delegate: UnknownLocationStateDelegate?
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureButton()
        configureMessageLabel()
        
        configureLayout()
    }
    
    private func configureButton() {
        requestLocationButton.setButtonTitle(with: "Access location")
        requestLocationButton.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    @objc private func onButtonTapped() {
        delegate?.askLocationPermission()
    }
    
    private func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints  = false
        messageLabel.textAlignment                              = .center
        messageLabel.font                                       = .systemFont(ofSize: 28)
        messageLabel.textColor                                  = .secondaryLabel
        messageLabel.text                                       = "Oops! Looks like we don't know where you are. Give us location access."
        messageLabel.numberOfLines                              = 0
        messageLabel.text                                       = NSLocalizedString("no_access_to_location_message", comment: "No access to location message was shawn")
    }
    
    private func configureLayout() {
        addSubview(requestLocationButton)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            requestLocationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            requestLocationButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
        ])
    }
}
