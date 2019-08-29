//
//  MovieViewModelTests.swift
//  Movie-DBTests
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import XCTest

class MovieViewModelTests: XCTestCase {
    
    var vm : MovieViewModel!
    
    override func setUp() {
        vm = MovieViewModel()
        vm.transform(MovieViewModelTests.mockMovieList())
    }
    
    /// Method tests total movie count
    func testGetListCountMethod() {
        XCTAssert(vm.getListCount() == 10, "getListCount method failed")
    }
    
    /// Method tests error for movies screen
    func testPageErrorForMovies() {
        XCTAssert(vm.getErrorMessage(false) == Constants.ErrorMessage.noResultFound, "page error failed")
    }
    
    /// Method tests paging
    func testValidPagingEnabled() {
        XCTAssert(vm.isShowNextMoviePage(4), "test valid paging enabled failed")
    }
    
    /// Method tests paging
    func testInValidPagingEnabled() {
        XCTAssert(!vm.isShowNextMoviePage(8), "test invalid paging enabled failed")
    }

}

// MARK: - mock data methods
extension MovieViewModelTests {
    
    class func mockMovieList() ->MovieList {
        let model = MovieList.init(results: getMovieObjectArray(10), page: 1, totalPages: 10)
        return model
    }
    
    class func getMovieObjectArray(_ count : Int) -> [MovieObject] {
        var arr = [MovieObject]()
        for _ in 1...count {
            arr.append(MovieObjectViewModelTests.mockMovieObjectModel())
        }
        return arr
    }
}
