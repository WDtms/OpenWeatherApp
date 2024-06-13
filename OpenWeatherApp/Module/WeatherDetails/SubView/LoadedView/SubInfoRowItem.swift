//
//  SubInfoRowItem.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class SubInfoRowItem: UIView {

    private let titleLabel: UILabel     = UILabel()
    private let subtitleLabel: UILabel  = UILabel()

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func changeSubtitleValue(with newVal: String) {
        subtitleLabel.text = newVal
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text     = title
        subtitleLabel.text  = subtitle
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureTitleLabel()
        configureSubtitleLabel()
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints    = false
        titleLabel.font                                         = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor                                    = .systemGray2
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font                                      = .systemFont(ofSize: 15, weight: .medium)
        subtitleLabel.textColor                                 = .systemGray
        
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
