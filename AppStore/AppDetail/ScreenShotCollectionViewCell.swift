//
//  ScreenShotCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 18/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class ScreenShotCollectionViewCell: UICollectionViewCell {
    
    lazy var screenShotCollectionViewController: ScreenShotCollectionViewController = {
        let collectionViewController = ScreenShotCollectionViewController()
        let layout = collectionViewController.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        return collectionViewController
    }()
    
    lazy var previewLabel: UILabel = {
        let label = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 24))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let verticalStackView = VerticalStackView(subViews: [
            previewLabel,
            screenShotCollectionViewController.view
            ], spacing: 4)
        addSubview(verticalStackView)
        verticalStackView.fillSuperView(with: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
