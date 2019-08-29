//
//  MovieListingViewController.swift
//  Movie-DB
//
//  Created by Sagar More on 24/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieListingViewController: UIViewController {
    let cellIdentifier = "MovieListingTableViewCell"
    private let padding : CGFloat = 8.0
    var viewModel : MovieViewModel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchField : UITextField!
    @IBOutlet weak var errorMessage : UILabel!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpViewModel()
        setUpSearchField()
        setUpScreen()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setUpViewModel() {
        viewModel = MovieViewModel()
        viewModel.delegate = self
        viewModel.getMovies()
    }
    
    private func setUpSearchField() {
        searchField.delegate = self
        //left padding to textfield
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height:searchField.frame.size.height))
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        //round shape to search field
        searchField.layer.borderColor = UIColor.gray.cgColor
        searchField.layer.borderWidth = 1.0
        searchField.layer.cornerRadius = searchField.bounds.size.height / 2
    }
    
    private func setUpScreen() {
        errorMessage.text  = viewModel.getErrorMessage()
        errorMessage.isHidden = true
    }

}

// MARK: - Movie View Model delegate methods
extension MovieListingViewController : MovieViewModelProtocol {
    
    func apiErrorUpdated(_ error: Error?) {
        print(error)
    }
    
    func movieListUpdated() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.errorMessage.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func emptyResult() {
        DispatchQueue.main.async {
            self.errorMessage.isHidden = false
        }
    }
}

// MARK: - textfield text change methods
extension MovieListingViewController : UITextFieldDelegate {
    
    // MARK: - On edit begin of textfield, on search screen
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.search) as? MovieSearchViewController {
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
        }
        return false
    }
}

// MARK: - Action Methods
extension MovieListingViewController {
    
    // MARK: - On Book button clicked, open details page of that movie.
    @objc func onBookClicked(_ sender : UIButton) {
        let vm = viewModel.getCellDataWith(sender.tag)
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.movieDetails) as? MovieDetailsViewController {
            vc.listVM = vm
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

