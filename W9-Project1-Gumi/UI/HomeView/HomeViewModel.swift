//
//  HomeViewModel.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

protocol HomeViewModelEvents: AnyObject {
    func showError(_ alert: UIAlertController)
    func returnData()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelEvents?
    
    var listOfTopics = [Topic]()
    var listOfMyPhotos = [MyPhoto]()
    
    init(delegate: HomeViewModelEvents?) {
        self.delegate = delegate
    }
    
    
    //MARK: - This function calls API and update listOfMyPhotos if success
    func getListOfPhoto() {
        APIManager.shared.call(type: MyPhotoAPI.getListPhotos(page: 1, perPage: 20), params: ["page": "1", "per_page": "20"], completionHandler: { (result: Result<[MyPhoto]?, ResponseError>) in
            switch result {
            case .success(let list):
                guard list != nil else { return }
                self.listOfMyPhotos = list!
                print("SUCCESS LOAD PHOTOS: \(self.listOfMyPhotos.count)")
                self.delegate?.returnData()
            case .failure(let error):
                print("FAIL LOAD PHOTOS \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.delegate?.showError(alert)
            }
        })
    }
    
    func getListOfTopic() {
        APIManager.shared.call(type: MyPhotoAPI.getListTopics, params: nil, completionHandler: { (result: Result<[Topic]?, ResponseError>) in
            switch result {
            case .success(let list):
                guard list != nil else { return }
                self.listOfTopics = list!
                print("SUCCESS LOAD TOPICS: \(self.listOfTopics.count)")
                self.delegate?.returnData()
            case .failure(let error):
                print("FAIL LOAD TOPICS \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.delegate?.showError(alert)
            }
        })
    }
}
