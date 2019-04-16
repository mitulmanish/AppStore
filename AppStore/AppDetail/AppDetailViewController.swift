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
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let appDetailSearchresultItem = searchResultItem,
            let cell = cell as? AppDetailCell else {
            return
        }
        cell.searchResultItem = appDetailSearchresultItem
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailCell, for: indexPath) as? AppDetailCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension AppDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    }
}
