//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Mitul Manish on 15/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var searchResultItem: SearchResultItem? {
        didSet {
            appIconImageView.sd_setImage(with: searchResultItem?.artworkURL)
            priceButton.setTitle(searchResultItem?.formattedPrice, for: .normal)
            appLabel.text = searchResultItem?.trackName
            releaseNotesLabel.text = searchResultItem?.releaseNotes
        }
    }
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 16)
        imageView.backgroundColor = .white
        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var appLabel = UILabel(
        text: "App name",
        font: .boldSystemFont(ofSize: 24),
        numberOfLines: 2
    )
    
    lazy var priceButton: UIButton = {
        let button = UIButton(text: "$ 4.99")
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 32 / 2.0
        return button
    }()
    
    lazy var whatsNewLabel = UILabel(
        text: "What's New",
        font: .boldSystemFont(ofSize: 20)
    )
    
    lazy var releaseNotesLabel = UILabel(
        text: "App notes",
        font: .systemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    lazy var verticalSpacer: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(subViews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(subViews: [
                    appLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]),
                    verticalSpacer
                    ], spacing: 12
                )
                ], spacing: 16
            ),
            whatsNewLabel,
            releaseNotesLabel
            ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperView(with: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
