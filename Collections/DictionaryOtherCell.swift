//
//  DictionaryOtherCell.swift
//  Collections
//
//  Created by Vitaly Khryapin on 29.12.2021.
//

import UIKit

class DictionaryOtherCell: UICollectionViewCell {
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
}
