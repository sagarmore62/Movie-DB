//
//  MovieListingTableViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 25/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieListingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblRelease : UILabel!
    @IBOutlet weak var lblDetails : UILabel!
    @IBOutlet weak var imgMovie : UIImageView!
    @IBOutlet weak var btnBook : UIButton!
    @IBOutlet weak var viewContainer : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        //add corner radius to movie image
        imgMovie.layer.cornerRadius = 3.0
        imgMovie.layer.masksToBounds = true
        //add corner radius to container view
        viewContainer.layer.cornerRadius = 5.0
        //add border to container view
        viewContainer.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        viewContainer.layer.borderWidth = 1.0
        //add shadow to container view
        viewContainer.layer.shadowColor = UIColor.gray.cgColor
        viewContainer.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowRadius = 4.0
    }
    
    
    /// Configure the cell UI
    ///
    /// - Parameter data: View Model for Movie Listing cell
    func configureCell(_ data : MovieObjectViewModel) {
        lblTitle.text = data.title
        lblRelease.text = data.releaseDate
        lblDetails.text = data.overview
        if let path = data.imagePath {
            imgMovie.getImageWith(path)
        }
    }

}
