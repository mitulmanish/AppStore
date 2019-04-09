//
//  AppsSearchCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 20/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchCollectionViewController: BaseCollectionViewController {
    private let cellID = "searchResultCellID"
    private let searchController = UISearchController(searchResultsController: .none)
    private var searchResultItemList = [SearchResultItem]()
    private var timer: Timer?
    
    lazy var emptySearchLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Please enter search term above 👆🏼"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.addSubview(emptySearchLabel)
        emptySearchLabel.fillSuperView(with: .init(top: 88, left: 48, bottom: 0, right: 48))
        
        collectionView.register(
            SearchResultsCell.self,
            forCellWithReuseIdentifier: SearchResultsCell.reuseIdentifier
        )
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func fetchAppsData(with searchTerm: String) {
        timer?.invalidate()
        timer = Timer(timeInterval: 0.3, repeats: false) { _ in
            Service.shared.fetchApps(searchTerm: searchTerm, completion: {
                [weak self] (result: Result<SearchResult, Error>) in
                guard let searchResults = try? result.get().results else {
                    return
                }
                self?.searchResultItemList = searchResults
                OperationQueue.main.addOperation {
                    self?.emptySearchLabel.isHidden = (searchResults.isEmpty == false)
                    self?.collectionView.reloadData()
                }
            })
        }
        timer?.fire()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SearchResultsCell else {
            return
        }
        let resultItem = searchResultItemList[indexPath.item]
        cell.nameLabel.text = resultItem.trackName
        cell.categoryLabel.text = resultItem.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(resultItem.averageUserRating ?? 0)"
        cell.appIconImageView.sd_setImage(with: resultItem.artworkURL)
        for (index, url) in resultItem.screenShotURLList.enumerated() {
            try? cell.screenShotImageViews.getElementAt(index: index).get().sd_setImage(with: url)
        }
    }
}

extension AppsSearchCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultItemList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultsCell.reuseIdentifier,
            for: indexPath
            ) as? SearchResultsCell else { return UICollectionViewCell() }
        return cell
    }
}

extension AppsSearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
}


extension AppsSearchCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty == false else {
            searchResultItemList = []
            emptySearchLabel.isHidden = false
            collectionView.reloadData()
            return
        }
        fetchAppsData(with: searchText)
    }
}
