//
//  ViewComponents.swift
//  AppStore
//
//  Created by Mitul Manish on 2/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: .none)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
    }
}
