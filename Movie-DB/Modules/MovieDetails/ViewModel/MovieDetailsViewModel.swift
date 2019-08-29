//
//  MoviesDetailsViewModel.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

protocol MovieDetailsProtocol : class {
    func reloadTable()
}

// MARK: - ViewModel for Movie Details
class MovieDetailsViewModel {
    weak var delegate : MovieDetailsProtocol?
    private let repo : MovieDetailsRepository
    private var dataSource = [MovieDetailsCellType]()
    private let movieListVM : MovieObjectViewModel
    
    init(_ listVM : MovieObjectViewModel) {
        movieListVM = listVM
        repo = MovieDetailsRepository()
    }
}

// MARK: - TableView operation methods
extension MovieDetailsViewModel {
    
    /// Returns number of rows
    ///
    /// - Returns: Number of rows
    func getNumberOfRows() -> Int {
        return dataSource.count
    }
    
    /// Returns data for cell at Row
    ///
    /// - Parameter indexPath: IndexPath for row
    /// - Returns: Cell data for row
    func getCellDataForRowAt(_ indexPath : Int) -> MovieDetailsCellType {
        return dataSource[indexPath]
    }
}

// MARK: - Api methods
extension MovieDetailsViewModel {
    
    /// Gets movie details
    func getMovieDetails() {
        getHeaderDetails(movieListVM)
        getReviews(movieListVM.movieId)
        getSimilarMovies(movieListVM.movieId)
    }
    
    private func getHeaderDetails(_ vm : MovieObjectViewModel)  {
        dataSource.append(.header(MovieDetailsHeaderViewModel.getMovieDetailsFormattedData(vm)))
        delegate?.reloadTable()
    }
    
    private func getReviews(_ movieId : Int) {
        repo.getReviews(movieId) { (data, error) in
            guard let unwrapped = data else {
                return
            }
            unwrapped.getJsonModel(modelType: MovieReviewModel.self, completionHandler: { [weak self] (model, error) in
                if let mod = model, !mod.results.isEmpty {
                    self?.dataSource.append(MovieDetailsCellType.review(mod.results))
                }
            })
        }
    }
    
    private func getSimilarMovies(_ movieId : Int) {
        repo.getSimilarMoview(movieId) { (data, error) in
            guard let unwrapped = data else {
                return
            }
            unwrapped.getJsonModel(modelType: MovieList.self, completionHandler: { [weak self] (model, error) in
                if let mod = model {
                    let vm = MovieViewModel()
                    vm.transform(mod)
                    if !vm.getMovieList().isEmpty {
                        self?.dataSource.append(MovieDetailsCellType.similarMovies(vm.getMovieList()))
                    }
                }
                self?.delegate?.reloadTable()
            })
        }
    }
}

/// Movie Details screen cell types
enum MovieDetailsCellType {
    case header(MovieDetailsHeaderViewModel)
    case review([MovieReview])
    case similarMovies([MovieObjectViewModel])
}

