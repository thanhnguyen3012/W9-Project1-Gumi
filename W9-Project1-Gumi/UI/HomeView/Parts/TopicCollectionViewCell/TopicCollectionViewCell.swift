//
//  TopicCollectionViewCell.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var highlighterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(topic: String) {
        topicLabel.text = topic
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
