//
//  SearchViewController.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!
    
    lazy var viewModel = SearchViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search photos"
        searchBar.showsScopeBar = true
        searchBar.barTintColor = UIColor(white: 0.97, alpha: 1)
        searchBar.scopeButtonTitles = ["Photos", "Collections", "Users"]
        searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        searchBar.showsCancelButton = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black], for: .normal)

        self.navigationItem.titleView = searchBar
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(ResultTableViewCell.nib, forCellReuseIdentifier: ResultTableViewCell.identifier)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchKey = searchBar.text else { return }
        let scope = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] ?? "Photos"
        
        print("SEARCH '\(searchKey)' in '\(scope)'")
        viewModel.search(key: searchKey, scope: scope)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.searchBarSearchButtonClicked(searchBar)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.amountOfResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        var url = ""
        var title = ""
        viewModel.getDataOfResultCell(url: &url, title: &title, index: indexPath.row)
        cell.loadImage(url: url, title: title)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailsView", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "detailsViewController") as? DetailsViewController else { return }
        vc.myPhoto = viewModel.listOfPhotos[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: SearchViewModelEvents {
    func showErorr(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func loadedPhotos() {
        print("Searched photos.")
        resultsTableView.allowsSelection = true
        resultsTableView.reloadData()
    }
    
    func loadedCollections() {
        print("Searched collections")
        resultsTableView.allowsSelection = false
        resultsTableView.reloadData()
    }
    
    func loadedUsers() {
        print("Searched users")
        resultsTableView.allowsSelection = false
        resultsTableView.reloadData()
    }
    
    
}
