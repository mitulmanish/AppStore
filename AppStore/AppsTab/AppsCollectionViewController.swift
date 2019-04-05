//
//  AppsCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 1/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppsCollectionViewController: BaseCollectionViewController {
    private let headerCellIdentifier = "headerCell"
    private var appGroup: AppGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: AppsGroupCollectionViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Service.shared.fetchGames { [weak self] (appGroup: AppGroup?, error) in
            self?.appGroup = appGroup
            OperationQueue.main.addOperation {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCollectionViewCell.reuseIdentifier, for: indexPath) as? AppsGroupCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = appGroup?.feed.title
        cell.horizontalController.appGroup = appGroup
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, for: indexPath) as? AppsHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 300)
    }
}

extension AppsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
