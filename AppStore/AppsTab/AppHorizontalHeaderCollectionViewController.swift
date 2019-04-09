//
//  AppHorizontalHeaderCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 2/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//
import UIKit

class AppHorizontalHeaderCollectionViewController: BaseCollectionViewController {
    private let identifier = "AppHorizontalHeaderCollectionViewCell"
    private let headerCellLeftSpacing: CGFloat = 16
    
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        collectionView.register(AppHorizontalHeaderCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? AppHorizontalHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        let socialItem = try? socialApps.getElementAt(index: indexPath.item).get()
        cell.titleLabel.text = socialItem?.tagline
        cell.companyLabel.text = socialItem?.name
        cell.appImageView.sd_setImage(with: URL(string: socialItem?.imageUrl ?? ""))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }
}

extension AppHorizontalHeaderCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width - 3 * headerCellLeftSpacing, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: headerCellLeftSpacing, bottom: 0, right: 0)
    }
}
