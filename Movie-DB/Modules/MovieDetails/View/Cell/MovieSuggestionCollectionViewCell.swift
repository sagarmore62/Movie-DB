//
//  MovieSuggestionCollectionViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieSuggestionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(_ data : MovieObjectViewModel) {
        if let img = data.imagePath {
            imgView.getImageWith(img)
        }
        lblTitle.text = data.title
    }

}
