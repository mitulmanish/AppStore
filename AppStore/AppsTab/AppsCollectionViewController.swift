//
//  AppsCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 1/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

enum AppGroupSection: CaseIterable {
    case newGames
    case newApps
    case topFree
    case topGrossing
    case topPaid
    case topFreeiPad
    case topGrossingiPad
    
    var urlString: String {
        switch self {
        case .newGames:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
        case .newApps:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
        case .topFree:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/10/explicit.json"
        case .topGrossing:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/10/explicit.json"
        case .topPaid:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/10/explicit.json"
        case .topFreeiPad:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free-ipad/all/10/explicit.json"
        case .topGrossingiPad:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing-ipad/all/10/explicit.json"
        }
    }
}

class AppsCollectionViewController: BaseCollectionViewController {
    private let headerCellIdentifier = "headerCell"
    
    private var appGroups = [AppGroup?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: AppsGroupCollectionViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAppGroupsData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCollectionViewCell.reuseIdentifier, for: indexPath) as? AppsGroupCollectionViewCell, let appGroup = appGroups[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, for: indexPath) as? AppsHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 0)
    }
}

extension AppsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Networking

extension AppsCollectionViewController {
    private func fetchAppGroupsData() {
        var appGroupDictionary = [Int: AppGroup?]()
        let dispatchGroup = DispatchGroup()
        for (index, section) in AppGroupSection.allCases.enumerated() {
            dispatchGroup.enter()
            Service.shared.fetch(urlString: section.urlString) { (result: Result<AppGroup, Error>) in
                dispatchGroup.leave()
                switch result {
                case let .success(appGroup):
                    appGroupDictionary[index] = appGroup
                case .failure:
                    break
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            let sortedAppGroupDictionary = appGroupDictionary.sorted { $0.0 < $1.0 }
            self?.appGroups = sortedAppGroupDictionary.compactMap({ $0.value })
            self?.collectionView.reloadData()
        }
    }
}
