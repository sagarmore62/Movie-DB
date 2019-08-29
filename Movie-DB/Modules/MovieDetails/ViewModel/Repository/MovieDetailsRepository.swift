//
//  MovieDetailsRepository.swift
//  Movie-DB
//
//  Created by Sagar More on 26/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

// MARK: - Repo for Movie Details Screen
struct MovieDetailsRepository {
    
    /// Get Reviews by Movie Id
    ///
    /// - Parameters:
    ///   - movieId: Movie id
    ///   - completionHandler: Handler returns Data & error for operation
    func getReviews(_ movieId : Int, completionHandler : @escaping (Data?, Error?) -> Void) {
        let url = String.init(format: EndPoint.reviews, movieId.description)
        NetworkService.startRequest(url, httpMethod: .get) { (data, err) in
            completionHandler(data, err)
        }
    }
    
    /// Get Similar movies by Movie Id
    ///
    /// - Parameters:
    ///   - movieId: Movie id
    ///   - completionHandler: Handler returns Data & error for operation
    func getSimilarMoview(_ movieId : Int, completionHandler : @escaping (Data?, Error?) -> Void) {
        let url = String.init(format: EndPoint.similarMoview, movieId.description)
        NetworkService.startRequest(url, httpMethod: .get) { (data, err) in
            completionHandler(data, err)
        }
    }
}
