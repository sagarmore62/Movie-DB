//
//  MovieDetailsViewController.swift
//  Movie-DB
//
//  Created by Sagar More on 28/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private let cellHeaderIdentifier = "MovieDetailsHeaderTableViewCell"
    private let cellReviewIdentifier = "MovieReviewsTableViewCell"
    private let cellSimilarIdentifier = "MovieSuggestionTableViewCell"
    
    private lazy var similarCellHeight : CGFloat = {
        let width = (UIScreen.main.bounds.size.width - 24 ) / 3
        return (width * 1.3) + 80
    }()
    private lazy var reviewsCellHeight : CGFloat = {
        let height = (UIScreen.main.bounds.size.width / 3 ) + 60
        return height
    }()
    
    var listVM : MovieObjectViewModel!
    private var viewModel : MovieDetailsViewModel!
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let _ = listVM else {
            fatalError("view model should be defined")
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: cellSimilarIdentifier, bundle: nil), forCellReuseIdentifier: cellSimilarIdentifier)
        viewModel = MovieDetailsViewModel.init(listVM)
        viewModel.delegate = self
        viewModel.getMovieDetails()
    }
}

// MARK: - ViewModel Delegate Method
extension MovieDetailsViewController : MovieDetailsProtocol {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate Methods
extension MovieDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellData = viewModel.getCellDataForRowAt(indexPath.row)
        switch cellData {
        case .header(_):
            return UITableView.automaticDimension
        case .review(_) :
            return reviewsCellHeight
        case .similarMovies(_):
            return similarCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewModel.getCellDataForRowAt(indexPath.row)
        switch cellData {
        case .header(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeaderIdentifier, for: indexPath) as! MovieDetailsHeaderTableViewCell
            cell.setupUI(value)
            return cell
        case .review(let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReviewIdentifier, for: indexPath) as! MovieReviewsTableViewCell
            cell.setupUI(value)
            return cell
        case .similarMovies(let value) :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSimilarIdentifier, for: indexPath) as! MovieSuggestionTableViewCell
            cell.setupUI(value)
            cell.delegate = self
            return cell
        }
    }

}

// MARK: - Suggestion movie cell delegate method
extension MovieDetailsViewController : MovieSuggestionProtocol {
    func onMovieSuggestionClicked(_ data: MovieObjectViewModel) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.movieDetails) as? MovieDetailsViewController {
            vc.listVM = data
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
