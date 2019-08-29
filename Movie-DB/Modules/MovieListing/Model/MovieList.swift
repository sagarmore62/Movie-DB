//
//  MovieList.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieList : Decodable {
    // list of movies in result
    var results        : [MovieObject]
    var page           : Int?
    var totalPages   : Int?
}


