//
//  SearchViewController.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search photos"
        searchBar.showsScopeBar = true
        searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.1)
        searchBar.scopeButtonTitles = ["Photos", "Collections", "Users"]
        searchBar.showsCancelButton = true

        self.navigationItem.titleView = searchBar
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
