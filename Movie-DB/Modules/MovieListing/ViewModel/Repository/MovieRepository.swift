//
//  MovieRepository.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

/// Repository to feed data for movie model
struct MovieRepository {
    
    /// method makes network call for movies result
    ///
    /// - Parameters:
    ///   - pageNo: page number 
    ///   - completionHandler: handler for data and error
    func getMovies( pageNo : Int, completionHandler : @escaping (Data?, Error?) -> Void) {
        let url = EndPoint.popularMovies + EndPoint.pagePath + pageNo.description + EndPoint.andPath
        NetworkService.startRequest(url, httpMethod: .get) { (data, err) in
            completionHandler(data, err)
        }
    }
}
