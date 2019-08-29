//
//  MovieSearchTableViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 25/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        //add corner radius to movie image
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
    }

    /// Configure Movie Search Cell UI
    ///
    /// - Parameter data: Movie Object View Model
    func configureCell(_ data : MovieObjectViewModel) {
        lblTitle.text = data.title
        if let path = data.imagePath {
            imgView.getImageWith(path)
        }
    }

}
