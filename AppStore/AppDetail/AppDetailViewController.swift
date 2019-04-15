//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Mitul Manish on 11/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
    }
}

class AppDetailCell: UICollectionViewCell {
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 16)
        imageView.backgroundColor = .white
        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
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
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AppDetailViewController: BaseCollectionViewController {
    
    private let appDetailCell = "appDetailCell"
    
    var appID: String {
        didSet {
            Service.shared.fetch(urlString: "https://itunes.apple.com/lookup?id=\(appID)") {
                (result: Result<SearchResult, Error>) in
                switch result {
                case .success(let searchResult):
                    print(searchResult.results.first?.description, searchResult.results.first?.releaseNotes)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.backgroundColor = .gray
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: appDetailCell)
        
        Service.shared.fetch(urlString: "https://itunes.apple.com/lookup?id=1152350815") {
            (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let searchResult):
                print(searchResult.results.first?.description, searchResult.results.first?.releaseNotes)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailCell, for: indexPath) as? AppDetailCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension AppDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 300)
    }
}
