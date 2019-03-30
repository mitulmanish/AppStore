//
//  AppsSearchCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 20/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchCollectionViewController: UICollectionViewController {
    private let cellID = "searchResultCellID"
    private var searchResultItemList = [SearchResultItem]()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(
            SearchResultsCell.self,
            forCellWithReuseIdentifier: SearchResultsCell.reuseIdentifier
        )
        
        fetchAppsData()
    }
    
    private func fetchAppsData() {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else {
            return
        }
        Service.shared.fetchApps(url: url, completion: { [weak self] appsList, error in
            guard let apps = appsList, apps.isEmpty == false else {
                return
            }
            self?.searchResultItemList = apps
            OperationQueue.main.addOperation {
                self?.collectionView.reloadData()
            }
        })
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
            try? cell.screenShotImageViews.getElementAt(index: index).sd_setImage(with: url)
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
