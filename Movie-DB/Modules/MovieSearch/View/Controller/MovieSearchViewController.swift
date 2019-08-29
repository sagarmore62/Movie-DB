//
//  MovieSearchViewController.swift
//  Movie-DB
//
//  Created by Sagar More on 25/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    private let cellIdentifier = "MovieSearchTableViewCell"
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchField : UITextField!
    @IBOutlet weak var lblErrorMessage : UILabel!
    var viewModel : MovieViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchField()
        setUpError()
        setUpTableView()
        viewModel.searchDelegate = self
        viewModel.updatedSearchedMovies(nil)
    }
    
    private func setUpSearchField() {
        searchField.becomeFirstResponder()
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)
        //left padding to textfield
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height:searchField.frame.size.height))
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        //round shape to search field
        searchField.layer.borderColor = UIColor.gray.cgColor
        searchField.layer.borderWidth = 1.0
        searchField.layer.cornerRadius = searchField.bounds.size.height / 2
    }
    
    private func setUpError() {
        lblErrorMessage.text = viewModel.getErrorMessage(true)
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: - Movie Search Protocol
extension MovieSearchViewController : MovieSearchProtocol {
    func movieSearchListUpdated() {
        tableView.reloadData()
        lblErrorMessage.isHidden = true
    }
    
    func movieFromCacheListUpdated() {
        tableView.reloadData()
        lblErrorMessage.isHidden = true
    }
    
    func emptyResult() {
        lblErrorMessage.isHidden = false
    }
}

// MARK: - textfield event methods
extension MovieSearchViewController : UITextFieldDelegate{
   
    @objc func textFieldTextChanged(_ textField : UITextField) {
        //binding view model variable with textfield
        viewModel.searchText = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: TableView Delegate Methods
extension MovieSearchViewController : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = viewModel.getCellDataWith(indexPath.row, true)
        viewModel.saveSearch(cellData)
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.movieDetails) as? MovieDetailsViewController {
            vc.listVM = cellData
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListCount(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewModel.getCellDataWith(indexPath.row, true)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieSearchTableViewCell
        cell.configureCell(cellData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSearchHeader()
    }
}
