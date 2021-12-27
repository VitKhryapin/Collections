//
//  OtherCollectionViewCell.swift
//  Collections
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import UIKit

class OtherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override var isSelected: Bool {
        willSet(newValue) {
            if newValue {
                backgroundColor = .systemGray4
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                otherLabel.isHidden = true
                
            } else {
                backgroundColor = .systemGray6
                activityIndicator.isHidden = true
                otherLabel.isHidden = false
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
}
