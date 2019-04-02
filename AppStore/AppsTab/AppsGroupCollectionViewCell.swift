//
//  AppsGroupCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 1/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppsGroupCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AppsGroupCollectionViewCellID"
    
    lazy var titleLabel: UILabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 20))
    
    lazy var horizontalController = AppsHorizontalCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ].forEach { $0.isActive = true }

        addSubview(horizontalController.view)
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        [horizontalController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
         horizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
         horizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
         horizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ].forEach { $0.isActive = true }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
