//
//  VerticalStackView.swift
//  AppStore
//
//  Created by Mitul Manish on 28/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(subViews: [UIView], spacing: CGFloat = 0.0) {
        super.init(frame: .zero)
        subViews.forEach { addArrangedSubview($0) }
        self.spacing = spacing
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
