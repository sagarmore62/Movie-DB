//
//  MovieDetailsHeaderTableViewCell.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieDetailsHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblRating : UILabel!
    @IBOutlet weak var lblOverview : UILabel!
    @IBOutlet weak var lblReleaseData : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupUI(_ data : MovieDetailsHeaderViewModel) {
        if let img = data.imagePath {
            imgView.getImageWith(img)
        }
        lblName.text = data.title
        lblRating.text = data.rating
        lblOverview.attributedText = data.overview
        lblReleaseData.attributedText = data.releaseData
    }

}
