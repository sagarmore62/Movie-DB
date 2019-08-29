//
//  MovieSearchViewModelTests.swift
//  Movie-DBTests
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import XCTest

class MovieSearchViewModelTests: XCTestCase {
    var searchVM : MovieSearchViewModel!

    override func setUp() {
        searchVM = MovieSearchViewModel()
    }
    
    /// This test getSearchedMovies() method
    func testGetSearchedMoviesMethod() {
        var search : [MovieObjectViewModel]?
        searchVM.getSearchedMovies("test", list: mockMovieListVMArray(), onCacheResult: { (cacheList) in
        }) { (searchList) in
            search = searchList
        }
        XCTAssert(search?.count == 10 , "get search movie method failed.")
    }
    
    /// Test header text for search page
    func testHeaderTextForSearch() {
        XCTAssertNil(searchVM.getHeaderText())
    }
}

// MARK: - Mock Data Methods
extension MovieSearchViewModelTests {
    
    // MARK: - Mock Movie list view model
    private func mockMovieListVMArray() -> [MovieObjectViewModel] {
        let vm = MovieViewModel()
        vm.transform(MovieViewModelTests.mockMovieList())
        return vm.getMovieList()
    }
}
