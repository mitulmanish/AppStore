//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Mitul Manish on 21/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    lazy var reviewLabel: UILabel = {
        let label = UILabel(text: "Reviews", font: .boldSystemFont(ofSize: 24))
        return label
    }()
    
    let appReviewsCollectionViewController = AppReviewsCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let stackView = VerticalStackView(subViews: [
            reviewLabel,
            appReviewsCollectionViewController.view
            ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperView(with: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
