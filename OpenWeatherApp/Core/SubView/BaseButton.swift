//
//  BaseButton.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class BaseButton: UIButton {
    
    private let labelHorizontalPadding: CGFloat = 24
    private let labelVerticalPadding: CGFloat = 16
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = .secondarySystemBackground
        buttonConfiguration.baseForegroundColor = .systemGray
        buttonConfiguration.contentInsets       = NSDirectionalEdgeInsets(top: labelVerticalPadding, leading: labelHorizontalPadding, bottom: labelVerticalPadding, trailing: labelHorizontalPadding)
        buttonConfiguration.cornerStyle         = .medium
        
        configuration = buttonConfiguration
    }
    
    func setButtonTitle(with title: String) {
        var currentConfiguration = self.configuration
        
        var attributedTitle                     = AttributedString(stringLiteral: title)
        attributedTitle.font                    = .systemFont(ofSize: 20)
        currentConfiguration?.attributedTitle   = attributedTitle
        
        self.configuration = currentConfiguration
    }
}
