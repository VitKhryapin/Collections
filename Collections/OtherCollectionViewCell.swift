//
//  OtherCollectionViewCell.swift
//  Collections
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import UIKit

class OtherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var otherLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.otherLabel.text = nil
    }
//    
//    func setupCell (arrayName: Cell) {
//        self.otherLabel.text = arrayName.name
//    }
}
