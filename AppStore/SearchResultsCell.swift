//
//  SearchResultsCell.swift
//  AppStore
//
//  Created by Mitul Manish on 26/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class SearchResultsCell: UICollectionViewCell {
    static let reuseIdentifier = "SearchResultsCellID"
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    
    private lazy var ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "1.6M"
        return label
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var screenShotImageViewFirst: UIImageView = {
        return createScreenshotImageView()
    }()
    
    private lazy var screenShotImageViewSecond: UIImageView = {
        return createScreenshotImageView()
    }()
    
    private lazy var screenShotImageViewThird: UIImageView = {
        return createScreenshotImageView()
    }()
    
    private func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 8
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        let labelStackView = VerticalStackView(subViews: [nameLabel, categoryLabel, ratingsLabel])
        let topInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelStackView, getButton])
        topInfoStackView.spacing = 12
        topInfoStackView.alignment = .center
        
        let screenShotsImageStackView = UIStackView(arrangedSubviews: [screenShotImageViewFirst, screenShotImageViewSecond, screenShotImageViewThird])
        screenShotsImageStackView.spacing = 8
        screenShotsImageStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(subViews: [topInfoStackView, screenShotsImageStackView], spacing: 8)
        addSubview(overallStackView)
        overallStackView.fillSuperView(with:
            .init(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16
            )
        )
    }
}
