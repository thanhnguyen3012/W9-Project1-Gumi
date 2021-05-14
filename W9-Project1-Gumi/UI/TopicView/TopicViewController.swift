//
//  TopicViewController.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 13/05/2021.
//

import UIKit

class TopicViewController: UIViewController {

    @IBOutlet weak var photosTableView: UITableView!
    
//    var topic: Topic?
    lazy var viewModel = TopicViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        navigationItem.setTitle(title: viewModel.topic?.title ?? "Unknown", subtitle: "Created by \(viewModel.topic?.owners?[0].name ?? "unknown")")
        
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.register(PhotoTableViewCell.nib, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        viewModel.getMyPhotoFromTopic()
    }
    
    func setTopic(topic: Topic){
        viewModel.topic = topic
    }

}

extension TopicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfMyPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        cell.loadImage(url: viewModel.listOfMyPhotos[indexPath.row].urls?.thumbnail ?? "")
        return cell
    }
}

extension TopicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = tableView.frame.width
        let size = viewModel.getPhotoSize(atIndex: indexPath.row)
        // 
        return width * (size.height / size.width)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailsView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "detailsViewController") as DetailsViewController
        vc.myPhoto = viewModel.listOfMyPhotos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopicViewController: TopicViewModelEvents {
    func loadedMyPhoto() {
        photosTableView.reloadData()
    }
    
    func showError(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
