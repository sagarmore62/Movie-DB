//
//  Movie_DBTests.swift
//  Movie-DBTests
//
//  Created by Sagar More on 24/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import XCTest
@testable import Movie_DB

class MovieObjectViewModelTests : XCTestCase {

    static let title = "Test Title"
    static let voteAverage : Float = 4.5
    static let movieId = 1
    static let overview = "Test Overview"
    static let releaseDate = "2019-05-03"
    
    /// Method test data binding of view model
    func testMovieObjectData() {
        let vm = MovieObjectViewModel.init(MovieObjectViewModelTests.mockMovieObjectModel())
        
        XCTAssert(vm.title == MovieObjectViewModelTests.title, "movie object view model description failed")
        XCTAssert(vm.movieId == MovieObjectViewModelTests.movieId, "movie object view model id failed")
        XCTAssert(vm.overview == MovieObjectViewModelTests.overview, "movie object view model overview failed")
        XCTAssert(vm.releaseDate == MovieObjectViewModelTests.releaseDate, "movie object view model overview failed")
        XCTAssert(vm.rating == "⭐️⭐️⭐️⭐️", "movie object view model rating failed")
        XCTAssertNil(vm.imagePath, "movie object view model image path failed")
    }

}

// MARK: - mock data methods
extension MovieObjectViewModelTests {
    class func mockMovieObjectModel() -> MovieObject {
        let model = MovieObject(title: title, posterPath: nil, voteAverage: voteAverage, id: movieId, overview: overview, releaseDate: releaseDate)
        return model
    }
}
