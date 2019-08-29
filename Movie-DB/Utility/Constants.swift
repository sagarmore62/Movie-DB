//
//  Constants.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

// MARK: - Constant file 
struct Constants {
    
    struct ErrorMessage {
        static let noResultFoundForSearch  = "no search results found"
        static let noResultFound  = "no results found"
    }
    
    struct PageTitle {
        static let movies = "MOVIES"
        static let favourite = "FAVOURITES"
    }
    
    struct StoryboardIdentifier {
        static let movieDetails = "MovieDetailsViewController"
        static let home = "HomeViewController"
        static let search = "MovieSearchViewController"
    }
    
    struct SearchPage {
        static let recentlySearched = "Recently searched"
    }
}
