//
//  MovieObjectViewModel.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieObjectViewModel : Codable {
    
    var imagePath : String?
    let title : String
    let rating : String
    let movieId : Int
    let overview : String?
    let releaseDate : String?
    
    /// Init method, which transforms model into view model
    /// - Parameter model: MovieObject model
    init(_ model : MovieObject) {
        //format full image path
        if let path = model.posterPath {
            imagePath = EndPoint.domainImage + "w400" + path
        }
        movieId = model.id
        overview = model.overview
        releaseDate = model.releaseDate
        title = model.title ?? ""
        //rating conversion
        let intRating = Int(model.voteAverage ?? 0)
        rating = (0..<intRating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
    }
    
    /// Returns array of title seperated by space
    ///
    /// - Returns: array of title seperated by space
    func getArrayTitle() -> [String] {
        return title.lowercased().components(separatedBy: " ")
    }

}
