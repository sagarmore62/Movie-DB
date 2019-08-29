//
//  MovieSearchViewModel.swift
//  Movie-DB
//
//  Created by Sagar More on 25/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

// MARK: - View Model for Search Screen
struct MovieSearchViewModel  {
    private var headerText : String?
}

extension MovieSearchViewModel {
    /// Method filters the existing movies list by search text
    ///
    /// - Parameter searchText: text for movies to search
    /// - Returns: list of filtered movies
    mutating func getSearchedMovies(_ searchText : String?, list : [MovieObjectViewModel] ,onCacheResult : ([MovieObjectViewModel]) -> Void, onSearchResult : ([MovieObjectViewModel]) -> Void )  {
        guard let text = searchText?.lowercased(), !text.isEmpty else {
            let cacheData = getPreviousSearch()
            headerText = cacheData.isEmpty ? nil : Constants.SearchPage.recentlySearched
            onCacheResult(cacheData)
            return
        }
        headerText = nil
        let newList = searchResult(searchText, list: list)
        onSearchResult(newList)
    }
    
    /// Method returns the headerText
    ///
    /// - Returns: headerText String value
    func getHeaderText() -> String? {
        return headerText
    }
    
    /// Method search for the text inside the list of movies
    /// It divides the search text by space first, then finds existence of each search word into list.
    ///
    /// - Parameters:
    ///   - searchText: search text
    ///   - list: list in which to search
    /// - Returns: list of MovieObjectViewModel which has search text
    private func searchResult(_ searchText : String?, list : [MovieObjectViewModel]) -> [MovieObjectViewModel] {
        //trim the search text for white space & new lines
        guard let text = searchText?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return []
        }
        //get search array text components seperated by single space
        let arrSearch = text.components(separatedBy: " ")
        //filter over the movie list
        let filteredList = list.filter({ (movie) -> Bool in
            return searchTextCompare(movie.getArrayTitle(), arrSearchList: arrSearch)
        })
        return filteredList
    }
    
    /// Compares array of list to other array of list for prefix
    ///
    /// - Parameters:
    ///   - arrResultList: Array of String which need to find
    ///   - arrSearchList: Array of String in which need to find
    /// - Returns: Returns boolean, which indicates existence of search
    private func searchTextCompare(_ arrResultList : [String], arrSearchList : [String]) -> Bool {
        for each in arrSearchList {
            let result = arrResultList.first { (element) -> Bool in
                return element.hasPrefix(each)
            }
            if result?.isEmpty ?? true {
                return false
            }
        }
        return true
    }
}

// MARK: - MovieSave Protocol methods
extension MovieSearchViewModel : MovieSaveProtocol {
    
    var key : String {
        return "savedSearch"
    }
    
    /// Method returns previously searched & cached movies
    ///
    /// - Returns: Array of movies in [MovieObjectViewModel]
    func getPreviousSearch() -> [MovieObjectViewModel] {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let array = try? decoder.decode([MovieObjectViewModel].self, from: data) {
                return array
            }
        }
        return []
    }
    
    /// Saves the searched movie.
    /// If no movie is saved in last, it just append new movie in cache array.
    /// If movie is already existed in cache array, it will not be saved.
    /// If previous cache movie array count is greater than 4, it removes last movie and add new movie to first position.
    /// If previous cache movie array count is less than 5, it adds new movie to first position.
    ///
    /// - Parameter vm: Movie to save in cache
    func saveSearch(_ vm : MovieObjectViewModel)  {
        var previousSearch = getPreviousSearch()
        if previousSearch.isEmpty {
            previousSearch.append(vm)
        } else {
            if let _ = previousSearch.first(where: {$0.movieId == vm.movieId}) {
                return
            }
            let count = previousSearch.count
            if count >= 5 {
                previousSearch = [vm] + previousSearch.dropLast()
            } else {
                previousSearch = [vm] + previousSearch
            }
        }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(previousSearch) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

// MARK: - Protocol for Movie save operation
protocol MovieSaveProtocol {
    var key : String {get}
    func saveSearch(_ vm : MovieObjectViewModel)
    func getPreviousSearch() -> [MovieObjectViewModel]
}

