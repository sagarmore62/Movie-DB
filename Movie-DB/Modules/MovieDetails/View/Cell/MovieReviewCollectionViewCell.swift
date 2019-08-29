//
//  MovieReviewCollectionViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblAuthor : UILabel!
    @IBOutlet weak var lblReview : UILabel!
    @IBOutlet weak var viewContainer : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //set border to viewContainer
        viewContainer.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        viewContainer.layer.borderWidth = 1.0
        //set shadow to viewContainer
        viewContainer.layer.shadowColor = UIColor.gray.cgColor
        viewContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowRadius = 3.0
    }
    
    func setupUI(_ data : MovieReview) {
        lblAuthor.text = data.author
        lblReview.text = data.content
    }

}
