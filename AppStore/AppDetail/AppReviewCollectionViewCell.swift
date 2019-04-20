//
//  AppReviewCollectionViewCell.swift
//  AppStore
//
//  Created by Mitul Manish on 21/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class AppReviewCollectionViewCell: UICollectionViewCell {
    
    let reviewTitleLabel: UILabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18), numberOfLines: 1)
    let authorLabel: UILabel = UILabel(text: "Author", font: .systemFont(ofSize: 16), numberOfLines: 1)
    let starsLabel: UILabel = UILabel(text: "⭐️", font: .systemFont(ofSize: 16), numberOfLines: 1)
    let bodylabel: UILabel = UILabel(text: #"""
        review
        review
        review
        """#, font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 0.9, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let verticalStackView = VerticalStackView(subViews: [
            UIStackView(arrangedSubviews: [
                reviewTitleLabel,
                UIView(),
                authorLabel]
            ),
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
