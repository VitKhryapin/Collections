//
//  FirstCollectionViewCell.swift
//  Collections
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var firstLabelOutlet: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override var isSelected: Bool {
        willSet(newValue) {
            if newValue {
                firstLabelOutlet.isHidden = true
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
//              backgroundColor = .systemGray4
            } else {
                firstLabelOutlet.isHidden = false
                activityIndicator.isHidden = true
                backgroundColor = .systemGray4
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
}
