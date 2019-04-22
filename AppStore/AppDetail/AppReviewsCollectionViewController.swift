//
//  AppReviewsCollectionViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 21/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

struct AppeReview: Decodable {
    let feed: AppReviewFeed
}

struct AppReviewFeed: Decodable {
    let entry: [AppEntryItem]
}

struct AppEntryItem: Decodable {
    let author: Author
    let content: AppReviewContent
    let title: AppReviewTitle
    let rating: AppRating
    
    private enum CodingKeys: String, CodingKey {
        case author, content, title
        case rating = "im:rating"
    }
}

struct AppRating: Decodable {
    let label: String
}

struct AppReviewTitle: Decodable {
    let label: String
}

struct AppReviewContent: Decodable {
    let label: String
}

struct Author: Decodable {
    let name: AuthorName
}

struct AuthorName: Decodable {
    let label: String
}

class AppReviewsCollectionViewController: UICollectionViewController {
    
    private let appReviewCellID = "appReviewCellID"
    
    static func horizontalLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    var appReview: AppeReview? {
        didSet {
            OperationQueue.main.addOperation {
                self.collectionView.reloadData()
            }
        }
    }
    
    var appID: String? {
        didSet {
            guard let id = appID else {
                return
            }
            Service.shared.fetch(urlString: "https://itunes.apple.com/rss/customerreviews/page=1/id=\(id)/sortby=mostrecent/json?l=en&cc=us") { [weak self] (result: Result<AppeReview, Error>) in
                switch result {
                case .success(let review):
                    self?.appReview = review
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    init(layout: UICollectionViewFlowLayout = AppReviewsCollectionViewController.horizontalLayout()) {
        super.init(collectionViewLayout: layout)
        collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppReviewCollectionViewCell.self, forCellWithReuseIdentifier: appReviewCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appReview?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appReviewCellID, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AppReviewCollectionViewCell, let review = appReview?.feed.entry.getElementAt(index: indexPath.item).value else {
            return
        }
        cell.appEntryItem = review
    }
}

extension AppReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 48, height: view.bounds.height)
    }
}
