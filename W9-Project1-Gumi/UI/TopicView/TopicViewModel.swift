//
//  TopicViewModel.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 13/05/2021.
//

import UIKit
import Alamofire

protocol TopicViewModelEvents: AnyObject {
    func loadedMyPhoto()
    func showError(_ alert: UIAlertController)
}

class TopicViewModel {
    
    var topic: Topic?
    var listOfMyPhotos = [MyPhoto]()
    
    weak var delegate: TopicViewModelEvents?
    
    init(delegate: TopicViewModelEvents?) {
        self.delegate = delegate
    }
    
    func getMyPhotoFromTopic() {
        guard let topicID = topic?.id else { return }
        APIManager.shared.call(type: MyPhotoAPI.getPhotosOfTopic(id: topicID), params: nil, completionHandler: { (result: Result<[MyPhoto]?, ResponseError>) in
            switch result {
            case .success(let list):
                self.listOfMyPhotos = list ?? []
                self.delegate?.loadedMyPhoto()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.delegate?.showError(alert)
            }
        })
    }
}
