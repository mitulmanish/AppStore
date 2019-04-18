//
//  ScreenShotImageCell.swift
//  AppStore
//
//  Created by Mitul Manish on 18/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//
import UIKit

class ScreenShotImageCell: UICollectionViewCell {
    var imageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 8)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
