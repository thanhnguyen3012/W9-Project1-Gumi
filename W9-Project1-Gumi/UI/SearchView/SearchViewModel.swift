//
//  SearchViewModel.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 13/05/2021.
//

import Foundation
import Alamofire

protocol SearchViewModelEvents: AnyObject {
    func loadedPhotos()
    func loadedCollections()
    func loadedUsers()
    func showError(_ alert: UIAlertController)
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelEvents?
    
    var amountOfResults = 0
    var searchMode = 0
    var listOfPhotos = [MyPhoto]() // searchMode = 0
    var listOfCollections = [Collection]() // searchMode = 1
    var listOfUsers = [User]() // searchMode = 2
    
    init(delegate: SearchViewModelEvents?) {
        self.delegate = delegate
    }
    
    func search(key: String, scope: String) {
        
        switch scope {
        case "Photos":
            searchPhotos(key: key)
        case "Collections":
            searchCollections(key: key)
        case "Users":
            searchUsers(key: key)
        default:
            return
        }
    }
    
    func searchPhotos(key: String) {
        searchMode = 0
        APIManager.shared.call(type: MyPhotoAPI.searchPhotos(query: key), completionHandler: { (result: Result<SearchResults<MyPhoto>?, ResponseError>) in
            switch result {
            case .success(let myResult):
                self.listOfPhotos = myResult?.results ?? []
                self.amountOfResults = self.listOfPhotos.count
                self.delegate?.loadedPhotos()
            case .failure(let error):
                self.delegate?.showError(APIManager.createErrorAlert(error: error))
            }
        })
    }
    
    func searchCollections(key: String) {
        searchMode = 1
        APIManager.shared.call(type: MyPhotoAPI.searchCollections(query: key), completionHandler: { (result: Result<SearchResults<Collection>?, ResponseError>) in
            switch result {
            case .success(let myResult):
                self.listOfCollections = myResult?.results ?? []
                self.amountOfResults = self.listOfCollections.count
                self.delegate?.loadedCollections()
            case .failure(let error):
                self.delegate?.showError(APIManager.createErrorAlert(error: error))
            }
        })
    }
    
    func searchUsers(key: String) {
        searchMode = 2
        APIManager.shared.call(type: MyPhotoAPI.searchUsers(query: key), completionHandler: { [self] (result: Result<SearchResults<User>?, ResponseError>) in
            switch result {
            case .success(let myResult):
                self.listOfUsers = myResult?.results ?? []
                self.amountOfResults = self.listOfUsers.count
                self.delegate?.loadedUsers()
            case .failure(let error):
                self.delegate?.showError(APIManager.createErrorAlert(error: error))
            }
        })
        
    }
    
    func getDataOfResultCell(url: inout String, title: inout String, index: Int) {
        switch searchMode {
        case 0:
            url = listOfPhotos[index].urls?.thumbnail ?? ""
            title = listOfPhotos[index].description ?? "Untitle"
        case 1:
            url = listOfCollections[index].coverPhoto?.urls?.thumbnail ?? ""
            title = listOfCollections[index].title ?? "Untitle"
        case 2:
            url = listOfUsers[index].profileImageUrl?.small ?? ""
            title = listOfUsers[index].name ?? ""
        default:
            return
        }
    }
}
