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
        
        Service.shared.fetch(urlString: "https://itunes.apple.com/rss/customerreviews/page=1/id=1201642309/sortby=mostrecent/json?l=en&cc=us") { (result: Result<AppeReview, Error>) in
            switch result {
            case .success(let review):
                print(review.feed.entry.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appReviewCellID, for: indexPath)
        return cell
    }
}

extension AppReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 48, height: view.bounds.height)
    }
}
