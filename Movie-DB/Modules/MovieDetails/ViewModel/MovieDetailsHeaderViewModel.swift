//
//  MovieDetailsHeaderViewModel.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

/// View Modal for movie details Header
struct MovieDetailsHeaderViewModel {
    let imagePath : String?
    let title : String
    let rating : String
    let overview : NSMutableAttributedString?
    let releaseData : NSMutableAttributedString?
    
    
    /// Method formats the data usable by movie details page
    /// - Returns: MovieDetailsHeaderViewModel
    static func getMovieDetailsFormattedData(_ vm : MovieObjectViewModel) ->MovieDetailsHeaderViewModel {
        let overViewAttr = MovieDetailsHeaderViewModel.getAttributedString("Overview", subTitle: vm.overview)
        let releaseAttr = MovieDetailsHeaderViewModel.getAttributedString("Release Date", subTitle: vm.releaseDate)
        return MovieDetailsHeaderViewModel.init(imagePath: vm.imagePath, title: vm.title,rating : vm.rating , overview: overViewAttr, releaseData: releaseAttr)
    }
    
    static func getAttributedString(_ title : String, subTitle : String?) -> NSMutableAttributedString? {
        guard let sub = subTitle else {
            return nil
        }
        let mainAttr = NSMutableAttributedString(string: title + " : ")
        mainAttr.addAttributes([NSMutableAttributedString.Key.font : AppTheme.Font.bold], range: NSMakeRange(0, mainAttr.length))
        let subAttr = NSAttributedString(string: sub, attributes : [NSMutableAttributedString.Key.font : AppTheme.Font.regular])
        mainAttr.append(subAttr)
        return mainAttr
    }
}
