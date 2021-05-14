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
    
    lazy var viewModel = HomeViewModel(delegate: self)
    
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
        
        viewModel.getListOfPhoto()
        viewModel.getListOfTopic()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "searchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imagesCollectionView:
            return viewModel.listOfMyPhotos.count
        case topicsCollectionView:
            return viewModel.listOfTopics.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imagesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            cell.tag = indexPath.row
            cell.loadImage(url: viewModel.listOfMyPhotos[indexPath.row].urls?.thumbnail ?? "", index: indexPath.row)
            return cell
        case topicsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            cell.bindData(topic: viewModel.listOfTopics[indexPath.row].title ?? "Unknown")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case topicsCollectionView:
            let storyboard = UIStoryboard(name: "TopicView", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "topicViewController") as? TopicViewController else { return }
            vc.setTopic(topic: viewModel.listOfTopics[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        case imagesCollectionView:
            let storyboard = UIStoryboard(name: "DetailsView", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "detailsViewController") as? DetailsViewController else { return }
            vc.myPhoto = self.viewModel.listOfMyPhotos[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ((collectionView == imagesCollectionView) && (indexPath.row == viewModel.listOfMyPhotos.count - 1)) {
            print("LOAD MORE")
            viewModel.getListOfPhoto()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imagesCollectionView {
            let width = (collectionView.frame.width - 45) / 2
            return CGSize(width: width, height: width)
        } else {
            return topicsCollectionView.contentSize
        }
    }
}

extension HomeViewController: HomeViewModelEvents {
    
    func showError(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func returnPhotos() {
        print("RELOAD \(viewModel.listOfMyPhotos.count)")
        imagesCollectionView.reloadData()
        
    }
    
    func returnTopics() {
        topicsCollectionView.reloadData()
    }
}
