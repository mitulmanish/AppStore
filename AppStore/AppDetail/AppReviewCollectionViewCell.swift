//
//  AppReviewCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 21/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppReviewCollectionViewCell: UICollectionViewCell {
    
    var appEntryItem: AppEntryItem? {
        didSet {
            reviewTitleLabel.text = appEntryItem?.title.label
            authorLabel.text = appEntryItem?.author.name.label
            bodylabel.text = appEntryItem?.content.label
            starsLabel.text = appEntryItem?.rating.label
            if let ratingIntEquivalent = Int(appEntryItem?.rating.label ?? "") {
                starsLabel.text = ["⭐️", "⭐️", "⭐️", "⭐️", "⭐️"]
                    .prefix(ratingIntEquivalent)
                    .reduce("", +)
            }
        }
    }
    
    lazy var reviewTitleLabel: UILabel = {
        let label = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18), numberOfLines: 1)
        label.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel(text: "Author", font: .systemFont(ofSize: 16))
        label.textAlignment = .right
        return label
    }()
    
    let starsLabel: UILabel = UILabel(text: "⭐️", font: .systemFont(ofSize: 16))
    let bodylabel: UILabel = UILabel(text: #"""
        review
        review
        review
        """#,
        font: .systemFont(ofSize: 16),
        numberOfLines: 5
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 0.9, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            reviewTitleLabel,
            authorLabel]
        )
        horizontalStackView.spacing = 4
        let verticalStackView = VerticalStackView(subViews: [
            horizontalStackView,
            starsLabel,
            bodylabel], spacing: 8)
        addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        [verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
            ].forEach { $0.isActive = true }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
