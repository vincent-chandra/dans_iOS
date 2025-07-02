//
//  BookmarkView.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class BookmarkView: UIViewController {
    
    @IBOutlet weak var emptyView: UIImageView!
    @IBOutlet weak var bookmarkCollectionView: UICollectionView!
    
    let feedList = FeedListItem.sharedInstance
    
    var presenter: BookmarkPresenter?
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 2
    
    var bookmarkFilteredList: [FeedEntityList] = [] {
        didSet {
            if bookmarkFilteredList.isEmpty {
                emptyView.isHidden = false
                bookmarkCollectionView.isHidden = true
            } else {
                emptyView.isHidden = true
                bookmarkCollectionView.isHidden = false
            }
            bookmarkCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bookmarkFilteredList = feedList.feedList.filter({ $0.isBookmarked == true })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        bookmarkCollectionView.delegate = self
        bookmarkCollectionView.dataSource = self
        bookmarkCollectionView.register(UINib(nibName: "BookmarkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookmarkCollectionViewCell")
        bookmarkCollectionView.contentInsetAdjustmentBehavior = .always
    }
}

extension BookmarkView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkFilteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmarkCollectionViewCell", for: indexPath) as? BookmarkCollectionViewCell
        let feed = bookmarkFilteredList[indexPath.item]
        cell?.authorLabel.text = feed.author ?? ""
        cell?.itemImage.loadImage(fromURL: feed.download_url ?? "")
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: 200)
    }
}
