//
//  LoadingStateView.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 10.06.2024.
//

import UIKit

class HomeLoadingStateView: UIView {

    let loadingIndicatorView : UIActivityIndicatorView = UIActivityIndicatorView()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureLoadingIndicatorView()
        configureLayout()
    }
    
    private func configureLoadingIndicatorView() {
        loadingIndicatorView.style = .large
        loadingIndicatorView.color = .systemGray
        
        loadingIndicatorView.startAnimating()
    }
    
    private func configureLayout() {
        addSubview(loadingIndicatorView)
        
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
