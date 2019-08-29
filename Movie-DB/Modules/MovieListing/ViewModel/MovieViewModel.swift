//
//  MovieViewModel.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    /// Contains initial movie list of popular movies
    private var list = [MovieObjectViewModel]() {
        didSet {
            delegate?.movieListUpdated()
        }
    }
    
    /// Contains filtered list of movies
    private var searchedList = [MovieObjectViewModel]()
    private var error : Error? {
        didSet {
            delegate?.apiErrorUpdated(error)
        }
    }
    private let repo : MovieRepository
    weak var delegate : MovieViewModelProtocol?
    weak var searchDelegate : MovieSearchProtocol?
    private var isPagingEnabled = true
    private var currentPageNo = 1
    private var totalPages = 0
    private var searchVM = MovieSearchViewModel()

    var searchText : String? {
        didSet {
            currentPageNo = 1
            totalPages = 1
            updatedSearchedMovies(searchText)
        }
    }
    
    init() {
        repo = MovieRepository()
    }
    
    /// Method hits api and updates the view model from result
    func getMovies() {
        getPopularMovies()
    }
    
    private func getPopularMovies() {
        repo.getMovies(pageNo: currentPageNo, completionHandler: { [unowned self] (data, err) in
            if let newData = data {
                newData.getJsonModel(modelType: MovieList.self, completionHandler: { (model, error) in
                    if let unwrapped = model {
                        if self.currentPageNo == 1 {
                            self.transform(unwrapped)
                        } else {
                            self.appendNewMovies(unwrapped)
                        }
                    } else {
                        self.error = error
                    }
                })
            } else {
                self.error = err
            }
        })
    }
    
    /// Method filters movie list by search text
    ///
    /// - Parameter searchText: search text
    func updatedSearchedMovies(_ searchText : String?) {
        searchVM.getSearchedMovies(searchText, list : list, onCacheResult: { (vm) in
            searchedList = vm
            searchDelegate?.movieFromCacheListUpdated()
        }) { (vm) in
           searchedList = vm
           searchDelegate?.movieSearchListUpdated()
           if searchedList.isEmpty {
              searchDelegate?.emptyResult()
           }
        }
    }
    
    func saveSearch(_ vm : MovieObjectViewModel) {
        searchVM.saveSearch(vm)
    }
    
    func getSearchHeader() -> String? {
        return searchVM.getHeaderText()
    }
    
    /// Method transforms model to view model
    /// - Parameter model: MovieList model
    func transform(_ model : MovieList) {
        let arr = model.results.map({ MovieObjectViewModel($0)})
        list = arr
        totalPages = model.totalPages ?? 0
    }
    
    /// Appends new movies to existing list
    ///
    /// - Parameter model: movie list model
    private func appendNewMovies(_ model : MovieList) {
        let arr = model.results.map({ MovieObjectViewModel($0)})
        list.append(contentsOf: arr)
    }
    
    /// Method return number of movies
    ///
    /// - Returns: Number of movies
    func getListCount(_ isSearchPage : Bool = false) -> Int {
        return isSearchPage ? searchedList.count : list.count
    }
    
    /// Method returns view model for for row at index
    ///
    /// - Parameter index: Index of view model
    /// - Returns: view model of moview
    func getCellDataWith(_ index : Int,_ isSearchPage : Bool = false) -> MovieObjectViewModel {
        return isSearchPage ? searchedList[index] : list[index]
    }
    
    /// Returns list of movies
    ///
    /// - Returns: array of movie objects
    func getMovieList() -> [MovieObjectViewModel] {
        return list
    }
    
}

extension MovieViewModel {
    
    /// Method returns error screen message
    ///
    /// - Parameter isFavourite: Boolean indicates error message requires for favourite screen or not
    /// - Returns: Error message in String
    func getErrorMessage (_ isSearchPage : Bool = false) -> String {
        return isSearchPage ? Constants.ErrorMessage.noResultFoundForSearch : Constants.ErrorMessage.noResultFound
    }
}

// MARK: - Pagination methods
extension MovieViewModel {
    /// Gets new page data for movies
    ///
    /// - Parameter indexPath : index path of collection view
    func getNextPageData(_ cellRow : Int) {
        if isShowNextMoviePage(cellRow) {
            currentPageNo += 1
            getPopularMovies()
        }
    }
    
    /// Method tells whether next page in pagination exist
    ///
    /// - Parameter cellRow: current cell row index in Int
    /// - Returns: Boolean tells next page existance status
    func isShowNextMoviePage(_ cellRow : Int) -> Bool {
        //while searching paging is disabled
        guard isPagingEnabled else {
            return false
        }
        if totalPages > currentPageNo {
            //next page api hits on 4th last cell in table view.
            if cellRow == (list.count - 4) {
                return true
            }
        } else {
            isPagingEnabled = false
        }
        return false
    }
}


