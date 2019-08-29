//
//  MovieSuggestionTableViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

protocol MovieSuggestionProtocol : class {
    func onMovieSuggestionClicked(_ data : MovieObjectViewModel)
}

class MovieSuggestionTableViewCell: UITableViewCell {
    
    private let cellIdentifier = "MovieSuggestionCollectionViewCell"
    weak var delegate : MovieSuggestionProtocol?
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    private var list : [MovieObjectViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        layout?.minimumLineSpacing = 8.0
        layout?.minimumInteritemSpacing = 8.0
        let width = (UIScreen.main.bounds.size.width - 24 ) / 3
        let height = (width * 1.3) + 30
        layout?.itemSize = CGSize(width: width, height: height)
    }
    
    func setupUI(_ data : [MovieObjectViewModel] ) {
        list = data
    }
    
}

extension MovieSuggestionTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = list![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieSuggestionCollectionViewCell
        cell.setupUI(cellData)
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData = list![indexPath.row]
        delegate?.onMovieSuggestionClicked(cellData)
    }

}
