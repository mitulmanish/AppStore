//
//  AppsHorizontalCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 2/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppsHorizontalCollectionViewCell: UICollectionViewCell {
    
    static let appsHorizontalCollectionViewCellIdentifier = "appsHorizontalCollectionViewCellID"
    lazy var appIconImageView: UIImageView =  { [unowned self] in
        let imageView = UIImageView(cornerRadius: 8)
        imageView.widthAnchor.constraint(
            equalToConstant: self.bounds.height * 0.9
            ).isActive = true
        imageView.heightAnchor.constraint(
            equalToConstant: self.bounds.height * 0.9
            ).isActive = true
        imageView.layer.cornerRadius = 8.0
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    lazy var appNameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel(text: "Company name", font: .systemFont(ofSize: 14))
        label.textColor = .lightGray
        return label
    }()
    
    lazy var getAppButton: UIButton = {
        let button = UIButton(text: "GET")
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 32 / 2
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        let verticalStackView = VerticalStackView(subViews: [appNameLabel, companyNameLabel], spacing: 4)
        let horizontalStackview = UIStackView(arrangedSubviews: [
            appIconImageView,
            verticalStackView,
            getAppButton
            ])
        horizontalStackview.spacing = 16
        horizontalStackview.alignment = .center
        addSubview(horizontalStackview)
        horizontalStackview.fillSuperView(with: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
}
