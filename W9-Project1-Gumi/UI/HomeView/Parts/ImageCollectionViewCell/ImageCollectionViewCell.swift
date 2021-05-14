//
//  ImageCollectionViewCell.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate {
    func imageCollectionViewCellDelegate(_ imageCollectionViewCell: ImageCollectionViewCell, _ loadedPhotoAt: UIImage, indexPath: Int)
}

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var delegate: ImageCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        thumbnailImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }
    
    func loadImage(url: String, index: Int) {
        thumbnailImageView.getImage(url: url, completionHandler: { [weak self] (img) in
            guard let self = self else { return }
            
            guard let image = img else {
                self.thumbnailImageView.image = UIImage(named: "placeholder")
                return
            }
            
            if self.tag == index {
                self.thumbnailImageView.image = image
                self.delegate?.imageCollectionViewCellDelegate(self, image, indexPath: self.tag)
            }
        })
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
