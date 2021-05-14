//
//  DetailsViewController.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 13/05/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var myPhoto: MyPhoto?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(myPhoto: myPhoto!)
        title = "Details"
    }
    
    func setupView(myPhoto: MyPhoto) {
        let imgWidth = contentView.frame.width - 30
        let imgHeight = CGFloat(Int(imgWidth) * (myPhoto.height ?? 0) / (myPhoto.width ?? 1))
        photoImageView.frame = CGRect(x: 15, y: 15, width: imgWidth, height: imgHeight)
        photoImageView.getImage(url: myPhoto.urls?.raw ?? "", completionHandler: { img in
            if img == nil {
                let alert = UIAlertController(title: "Error", message: "Cannot loading photo from URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        authorLabel.text = myPhoto.user?.name ?? "Undefined"
        titleLabel.text = myPhoto.description ?? "Untitle"
        
        descriptionTextView.text = myPhoto.altDescription ?? "No description"
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        
        var categories = ""
        if (myPhoto.categories ?? []).count == 0 {
            categories = "Undefined."
        } else {
            for category in myPhoto.categories ?? [] {
                categories = categories + category + ", "
            }
        }
        categoriesTextView.text = categories
        categoriesTextView.isScrollEnabled = false
        categoriesTextView.sizeToFit()
        categoriesTextView.isEditable = false
    }
}
