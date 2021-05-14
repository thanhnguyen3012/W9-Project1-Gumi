//
//  HomeViewModel.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

protocol HomeViewModelEvents: AnyObject {
    func showError(_ alert: UIAlertController)
    func returnPhotos()
    func returnTopics()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelEvents?
    
    var listOfTopics = [Topic]()
    var listOfMyPhotos = [MyPhoto]()
    var page = 1
    
    init(delegate: HomeViewModelEvents?) {
        self.delegate = delegate
    }
    
    //MARK: - This function calls API and update listOfMyPhotos if success
    func getListOfPhoto() {
        page += 1
        APIManager.shared.call(type: MyPhotoAPI.getListPhotos(page: page, perPage: 20), completionHandler: { (result: Result<[MyPhoto]?, ResponseError>) in
            switch result {
            case .success(let list):
                guard list != nil else { return }
                self.listOfMyPhotos.append(contentsOf: list!)
                print("SUCCESS LOAD PHOTOS: \(self.listOfMyPhotos.count)")
                self.delegate?.returnPhotos()
            case .failure(let error):
                print("FAIL LOAD PHOTOS \(error.localizedDescription)")
                self.delegate?.showError(APIManager.createAlert(error: error))
            }
        })
    }
    
    func getListOfTopic() {
        APIManager.shared.call(type: MyPhotoAPI.getListTopics, completionHandler: { (result: Result<[Topic]?, ResponseError>) in
            switch result {
            case .success(let list):
                guard list != nil else { return }
                self.listOfTopics = list!
                print("SUCCESS LOAD TOPICS: \(self.listOfTopics.count)")
                self.delegate?.returnTopics()
            case .failure(let error):
                print("FAIL LOAD TOPICS \(error.localizedDescription)")
                self.delegate?.showError(APIManager.createAlert(error: error))
            }
        })
    }
}
