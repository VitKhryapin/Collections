//
//  ArrayCollectionViewController.swift
//  Collections
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import UIKit


class ArrayCollectionViewController: UICollectionViewController {
    let idCell = "cell"
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var result: String = "Create Int array with 10_000_000 elements"
    var array: Array<Any> = []
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.delegate = self
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if array.count == 0 {
            return 1
        } else {
            return array.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionViewCell", for: indexPath) as! OtherCollectionViewCell
        firstCell.backgroundColor = .systemGray3
        firstCell.layer.borderWidth = 0.5
        firstCell.firstLabelOutlet.text = result
        otherCell.backgroundColor = .systemGray3
        otherCell.layer.borderWidth = 0.5
        if array.count == 0 {
            otherCell.isHidden = true
        } else {
            otherCell.isHidden = false
        }
        if indexPath.item == 0 {
            return firstCell
        } else {
            return otherCell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            createArray()
        }
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        self.collectionView.reloadData()
    
    }
    
    func createArray () -> String {
        let start = DispatchTime.now()
        array = Array (0...9_999_999)
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000
        result = String(format: "%@: %.3f ms.","Array creation time", timeInterval)
        return result
    }
    
}





extension ArrayCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            let availableWidth = collectionView.frame.width
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.right
    }
}
