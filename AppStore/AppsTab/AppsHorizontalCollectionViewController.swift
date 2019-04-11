//
//  AppsHorizontalCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 1/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppsHorizontalCollectionViewController: BaseCollectionViewController {
    private let interItemSpacing: CGFloat = 10
    private let topBottomSectionMargin: CGFloat = 8
    
    var didSelectApp: ((FeedResult) -> ())?
    
    var appGroup: AppGroup? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        collectionView.register(AppsHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: AppsHorizontalCollectionViewCell.appsHorizontalCollectionViewCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHorizontalCollectionViewCell.appsHorizontalCollectionViewCellIdentifier, for: indexPath) as? AppsHorizontalCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let appItem = appGroup?.feed.results.getElementAt(index: indexPath.item).value else {
            return cell
        }
        cell.appNameLabel.text = appItem.name
        cell.companyNameLabel.text = appItem.artistName
        cell.appIconImageView.sd_setImage(with: URL(string: appItem.artworkUrl100))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let appItem = appGroup?.feed.results.getElementAt(index: indexPath.item).value else {
            return
        }
        didSelectApp?(appItem)
    }
}

extension AppsHorizontalCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (collectionView.bounds.height - (2 * topBottomSectionMargin) - (2 * interItemSpacing)) / 3.0
        let width = collectionView.bounds.width - 48
        return .init(width: width, height: height.rounded())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomSectionMargin, left: 16, bottom: topBottomSectionMargin, right: 16)
    }
}
