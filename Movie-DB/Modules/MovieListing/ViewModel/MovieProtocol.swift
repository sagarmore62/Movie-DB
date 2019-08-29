//
//  MovieProtocol.swift
//  Movie-DB
//
//  Created by Sagar More on 27/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

// MARK: - Movie View Model protocol
protocol MovieViewModelProtocol : class {
    func movieListUpdated()
    func apiErrorUpdated(_ error : Error?)
    func emptyResult()
}

// MARK: - Movie Search Protocol
protocol MovieSearchProtocol : class {
    func movieSearchListUpdated()
    func movieFromCacheListUpdated()
    func emptyResult()
}
