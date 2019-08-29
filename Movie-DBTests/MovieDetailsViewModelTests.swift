//
//  MovieDetailsViewModelTests.swift
//  Movie-DBTests
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import XCTest

class MovieDetailsViewModelTests: XCTestCase {

    var viewModel : MovieDetailsViewModel!
    
    override func setUp() {
        viewModel = getMockViewModel()
    }
    
    /// Test getNumberOfRows method
    func testGetNumberOfRows() {
        XCTAssert(viewModel.getNumberOfRows() == 0, "get number of rows method failed.")
    }
    
}

// MARK: - Mock View Model methods
extension MovieDetailsViewModelTests {
    
    private func getMockViewModel() -> MovieDetailsViewModel {
        let movieVM = MovieObjectViewModel.init(MovieObjectViewModelTests.mockMovieObjectModel())
        let vm = MovieDetailsViewModel(movieVM)
        return vm
    }
}
