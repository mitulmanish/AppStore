//
//  AppHorizontalHeaderCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 2/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppHorizontalHeaderCollectionViewCell: UICollectionViewCell {
    
    lazy var companyLabel: UILabel = {
        let label = UILabel(text: "Seller Name", font: .systemFont(ofSize: 12, weight: .semibold))
        label.textColor = .blue
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(text: "Enpass Password Manager \nAll your passwords, in one place", font: .systemFont(ofSize: 24))
        label.numberOfLines = 2
        return label
    }()
    
    let appImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 8)
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalStackView = VerticalStackView(subViews: [
            companyLabel, titleLabel, appImageView], spacing: 8)
        addSubview(verticalStackView)
        verticalStackView.fillSuperView(with: .init(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
