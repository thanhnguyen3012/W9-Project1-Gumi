//
//  UIImageView+Cache.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 11/05/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func getImage(url stringUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
        let url = URL(string: stringUrl)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                self.kf.indicatorType = .none
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                self.kf.indicatorType = .none
                print("Job failed: \(error.localizedDescription)")
            }
        }

    }
}
