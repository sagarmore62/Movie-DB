//
//  MovieReviewsTableViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieReviewsTableViewCell: UITableViewCell {
    private let cellIdentifier = "MovieReviewCollectionViewCell"
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var pageIndicator : UIPageControl!
    private var list : [MovieReview]? {
        didSet {
            collectionView.reloadData()
            pageIndicator.numberOfPages = list?.count ?? 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupCollectionView()
    }
    
    func setupUI(_ data : [MovieReview]) {
        list = data
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout?.minimumLineSpacing = 0.0
        layout?.minimumInteritemSpacing = 0.0
        let width = UIScreen.main.bounds.size.width
        let height = width / 3
        layout?.itemSize = CGSize(width: width, height: height)
    }
    
}

extension MovieReviewsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = list![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieReviewCollectionViewCell
        cell.setupUI(cellData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageIndicator.currentPage = indexPath.row
    }
    
}
