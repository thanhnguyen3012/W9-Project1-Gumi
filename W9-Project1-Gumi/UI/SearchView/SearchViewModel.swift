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
    func showErorr(_ alert: UIAlertController)
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
        let params: Parameters? = ["query": key]
        APIManager.shared.call(type: MyPhotoAPI.searchPhotos, completionHandler: { (result: Result<[SearchResults<MyPhoto>]?, ResponseError>) in
            switch result {
            case .success(let list):
                self.listOfPhotos = list?[0].results ?? []
                self.delegate?.loadedPhotos()
            case .failure(let error):
                self.delegate?.showErorr(self.createErrorAlert(error: error))
            }
        })
//        switch scope {
//        case "Photos":
//            searchMode = 0
//            APIManager.shared.call(type: MyPhotoAPI.searchPhotos, params: params, completionHandler: { (result: Result<[MyPhoto]?, ResponseError>) in
//                switch result {
//                case .success(let list):
//                    self.listOfPhotos = list ?? []
//                    self.delegate?.loadedPhotos()
//                case .failure(let error):
//                    self.delegate?.showErorr(self.createErrorAlert(error: error))
//                }
//            })
//        case "Collections":
//            searchMode = 1
//            APIManager.shared.call(type: MyPhotoAPI.searchCollections, params: params, completionHandler: { (result: Result<[Collection]?, ResponseError>) in
//                switch result {
//                case .success(let list):
//                    self.listOfCollections = list ?? []
//                    self.delegate?.loadedCollections()
//                case .failure(let error):
//                    self.delegate?.showErorr(self.createErrorAlert(error: error))
//                }
//            })
//        case "Users":
//            searchMode = 2
//            APIManager.shared.call(type: MyPhotoAPI.searchUsers, params: params, completionHandler: { (result: Result<[User]?, ResponseError>) in
//                switch result {
//                case .success(let list):
//                    self.listOfUsers = list ?? []
//                    self.delegate?.loadedUsers()
//                case .failure(let error):
//                    self.delegate?.showErorr(self.createErrorAlert(error: error))
//                }
//            })
//        default:
//            return
//        }
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
    
    private func createErrorAlert(error: ResponseError) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
}
