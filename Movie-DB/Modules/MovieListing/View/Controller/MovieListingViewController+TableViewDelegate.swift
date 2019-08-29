//
//  MovieListingViewController+TableViewDelegate.swift
//  Movie-DB
//
//  Created by Sagar More on 25/08/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

// MARK: - Tableview Delegate Methods
extension MovieListingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewModel.getCellDataWith(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieListingTableViewCell
        cell.btnBook.tag = indexPath.row
        cell.btnBook.addTarget(self, action: #selector(onBookClicked(_:)), for: .touchUpInside)
        cell.configureCell(cellData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.getNextPageData(indexPath.row)
    }
    
}
