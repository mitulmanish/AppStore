//
//  ScreenShotCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 18/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class ScreenShotCollectionViewController: BaseCollectionViewController {
    
    private let screenShotImageCellID = "screenShotImageCellID"
    
    var screenShotImageURLs: [URL]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        collectionView.register(ScreenShotImageCell.self, forCellWithReuseIdentifier: screenShotImageCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotImageCellID, for: indexPath) as? ScreenShotImageCell else {
            return UICollectionViewCell()
        }
        cell.imageView.sd_setImage(with: screenShotImageURLs?.getElementAt(index: indexPath.item).value, completed: nil)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenShotImageURLs?.count ?? 0
    }
}

extension ScreenShotCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: collectionView.bounds.height)
    }
}
