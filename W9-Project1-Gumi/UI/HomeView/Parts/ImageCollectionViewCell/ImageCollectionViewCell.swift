//
//  ImageCollectionViewCell.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(img: UIImage) {
        thumbnailImageView.image = img
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
