//
//  HomeViewController.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var topicsCollectionView: UICollectionView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Home"
        
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        topicsCollectionView.register(TopicCollectionViewCell.nib, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        //Test call API by Alamofire
        loading(page: 1, perPage: 3, completionHandler: { result in
            switch result {
            case .success(let listPhotos):
                print("== Result list: \(listPhotos!.count)")
                for photo in listPhotos! {
                    print(photo.description)
                }
            case .failure(let error):
                print("== Error: \(error.localizedDescription)")
            }
        })
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "searchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loading(page: Int, perPage: Int, completionHandler: @escaping (_ result: Result<[MyPhoto]?, ResponseError>) -> ()) {
        let par : Parameters = ["per_page" : "1"]
        APIManager.shared.call(type: MyPhotoAPI.getListPhotos(page: page, perPage: perPage), params: par) { (result: Result<[MyPhoto]?, ResponseError>) in
            switch result {
            case .success(let myPhotos):
                print("==Success: \(myPhotos)")
                completionHandler(.success(myPhotos))
            case .failure(let error):
                print("==Error: \(error)")
                completionHandler(.failure(error))
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imagesCollectionView:
            return 2
        case topicsCollectionView:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imagesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            cell.bindData(img: UIImage(named: "placeholder")!)
            return cell
        case topicsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            cell.bindData(topic: "New")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

