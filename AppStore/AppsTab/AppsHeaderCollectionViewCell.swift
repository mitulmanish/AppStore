//
//  AppsHeaderCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 2/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppsHeaderCollectionViewCell: UICollectionViewCell {
    
    let appHeaderCollectionViewController = AppHorizontalHeaderCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        
        addSubview(appHeaderCollectionViewController.view)
        appHeaderCollectionViewController.view.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
