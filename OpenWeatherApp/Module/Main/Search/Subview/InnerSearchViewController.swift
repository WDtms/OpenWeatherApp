//
//  InnerSearchViewController.swift
//  OpenWeatherApp
//
//  Created by Aleksey Shepelev on 12.06.2024.
//

import UIKit

protocol InnerSearchViewControllerDelegate {
    func handleTapped(on: CityViewModel)
}

class InnerSearchViewController: UIViewController {
    enum Section {
        case main
    }
    
    var searchResults: [CityViewModel] = []
    
    var searchResultsCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CityViewModel>!
    var delegate: InnerSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func refreshSearchedList(with list: [CityViewModel]) {
        self.searchResults = list
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CityViewModel>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(list)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        let layout                       = UICollectionViewFlowLayout()
        layout.sectionInset              = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize                  = CGSize(width: view.bounds.width, height: 60)
        layout.minimumLineSpacing        = 20
        
        searchResultsCollectionView                 = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        searchResultsCollectionView.backgroundColor = UIColor.clear
        
        searchResultsCollectionView.register(SearchedCollectionViewCell.self, forCellWithReuseIdentifier: SearchedCollectionViewCell.identifier)
        searchResultsCollectionView.translatesAutoresizingMaskIntoConstraints   = false
        searchResultsCollectionView.delegate                                    = self
        
        view.addSubview(searchResultsCollectionView)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: searchResultsCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchedCollectionViewCell.identifier, for: indexPath) as? SearchedCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(with: itemIdentifier)
            
            return cell
        })
    }
}

extension InnerSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.handleTapped(on: self.searchResults[indexPath.row])
    }
}
