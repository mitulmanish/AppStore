//
//  AppReviewsCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 21/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppReviewsCollectionViewController: UICollectionViewController {
    
    private let appReviewCellID = "appReviewCellID"
    
    static func horizontalLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    init(layout: UICollectionViewFlowLayout = AppReviewsCollectionViewController.horizontalLayout()) {
        super.init(collectionViewLayout: layout)
        collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppReviewCollectionViewCell.self, forCellWithReuseIdentifier: appReviewCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appReviewCellID, for: indexPath)
        return cell
    }
}

extension AppReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 48, height: view.bounds.height)
    }
}
