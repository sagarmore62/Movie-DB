//
//  MovieSimilarModel.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieReviewModel : Decodable {
    let results : [MovieReview]
}

struct MovieReview : Decodable {
    let author : String
    let content : String
    let id : String
    let url : String
}
