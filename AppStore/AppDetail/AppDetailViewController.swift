//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 11/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppDetailViewController: BaseCollectionViewController {
    
    private let appDetailCell = "appDetailCell"
    private let screenShotCell = "screenShotCell"
    
    private let appID: String
    private var searchResultItem: SearchResultItem?
    
    init(appID: String) {
        self.appID = appID
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func fetchAppDetailsData() {
        Service.shared.fetch(urlString: "https://itunes.apple.com/lookup?id=\(appID)") {
            [weak self] (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let searchResult):
                self?.searchResultItem = searchResult.results.first
                OperationQueue.main.addOperation {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: appDetailCell)
        fetchAppDetailsData()
        collectionView.register(ScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: screenShotCell)
        collectionView.backgroundColor = .white
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            guard let appDetailSearchresultItem = searchResultItem,
                let cell = cell as? AppDetailCell else {
                    return
            }
            cell.searchResultItem = appDetailSearchresultItem
        case 1:
            guard let appDetailSearchresultItem = searchResultItem,
                let cell = cell as? ScreenShotCollectionViewCell else {
                    return
            }
            cell.screenShotCollectionViewController.screenShotImageURLs = appDetailSearchresultItem.screenShotURLList
        default:
            return
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailCell, for: indexPath) as? AppDetailCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotCell, for: indexPath) as? ScreenShotCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension AppDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            let sampleCell = AppDetailCell(frame:
                .init(
                    x: 0,
                    y: 0,
                    width: collectionView.bounds.width,
                    height: 0.0
                )
            )
            
            sampleCell.searchResultItem = searchResultItem
            sampleCell.layoutIfNeeded()
            let probableSize = sampleCell.systemLayoutSizeFitting(.init(
                width: collectionView.bounds.width,
                height: 0.0
                )
            )
            
            return .init(width: collectionView.bounds.width, height: probableSize.height)
        case 1:
            return .init(width: collectionView.bounds.width, height: 328)
        default:
            return .zero
        }
    }
}
