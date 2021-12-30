//
//  DictionaryCollectionViewController.swift
//  Collections
//
//  Created by Vitaly Khryapin on 29.12.2021.
//

import UIKit

class DictionaryCollectionViewController: UICollectionViewController {
    @IBOutlet weak var activityIndicatorCV: UIActivityIndicatorView!
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let queue = DispatchQueue.global(qos: .utility)
    var array: ArrayName = ArrayName()
    var dictionary: Dictionary <String, String> = [:]
    let count = 10_000_000
    var checkCreate = false
    var startTimer = DispatchTime.now()
    var endTimer = DispatchTime.now()
    var resultNumber = ""
    var resultTime = ""
    var cell1 = "Find the first contact"
    var cell2 = "Find the last contact"
    var cell3 = "Search for a non-existing element"
    var cell4 = "Find the first contact"
    var cell5 = "Find the last contact"
    var cell6 = "Search for a non-existing element"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView?.allowsMultipleSelection = true
        create {
            self.collectionView.reloadData()
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            checkCreate = false
        }
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if array.arrayName.count == count && dictionary.count == count {
            activityIndicatorCV.isHidden = true
            return 8
        } else {
            activityIndicatorCV.isHidden = false
            return 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let arrayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrayColumnCollectionViewCell", for: indexPath) as! NameColumnCollectionViewCell
        let dictionaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DictionaryColumnCollectionViewCell", for: indexPath) as! NameColumnCollectionViewCell
        let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DictionaryOtherCell", for: indexPath) as! DictionaryOtherCell
        var cell = UICollectionViewCell()
        otherCell.layer.borderWidth = 0.5
        
        switch indexPath.item {
        case 0:
            cell = arrayCell
        case 1:
            cell = dictionaryCell
        case 2:
            otherCell.otherLabel.text = cell1
            cell = otherCell
        case 3:
            otherCell.otherLabel.text = cell4
            cell = otherCell
        case 4:
            otherCell.otherLabel.text = cell2
            cell = otherCell
        case 5:
            otherCell.otherLabel.text = cell5
            cell = otherCell
        case 6:
            otherCell.otherLabel.text = cell3
            cell = otherCell
        case 7:
            otherCell.otherLabel.text = cell6
            cell = otherCell
        default:
            break
        }
        return cell
    }
    
    
    
    func create (completion: @escaping () -> Void) {
        guard !checkCreate else { return }
        checkCreate = true
        array.arrayName.removeAll()
        dictionary.removeAll()
        queue.async {
            for i in 0..<self.count where self.checkCreate != false {
                self.array.arrayName.append(Person(name: "Name\(i)", phone: "1234-\(i)"))
                self.dictionary["Name\(i)"] = String("1223-\(i)")
            }
            guard self.array.arrayName.count == self.count, self.dictionary.count == self.count else { return }
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            startTimer = DispatchTime.now()
            resultNumber = "\(array.arrayName[0].phone)"
            endTimer = DispatchTime.now()
            timer()
            cell1 = "First element search time: \(resultTime) Result number: \(resultNumber)"
            collectionView.reloadData()
        case 3:
            startTimer = DispatchTime.now()
            guard dictionary["Name0"] != nil else { return }
            resultNumber = dictionary["Name0"]!
            endTimer = DispatchTime.now()
            timer()
            cell4 = "First element search time: \(resultTime) Result number: \(resultNumber)"
            collectionView.reloadData()
        case 4:
            startTimer = DispatchTime.now()
            resultNumber = "\(array.arrayName[array.arrayName.count - 1].phone)"
            endTimer = DispatchTime.now()
            timer()
            cell2 = "Last element search time: \(resultTime) Result number: \(resultNumber)"
            collectionView.reloadData()
        case 5:
            startTimer = DispatchTime.now()
            guard dictionary["Name\(dictionary.count-1)"] != nil else { return }
            resultNumber = dictionary["Name\(dictionary.count-1)"]!
            endTimer = DispatchTime.now()
            timer()
            cell5 = "Last element search time: \(resultTime) Result number: \(resultNumber)"
            collectionView.reloadData()
        case 6:
            startTimer = DispatchTime.now()
            array.arrayName.remove(at: count / 2)
            queue.async {
                for i in 0..<self.array.arrayName.count {
                    if self.array.arrayName[i].phone != "1234-\(i)" {
                        self.resultNumber = "1234-\(i)"
                        self.array.arrayName.insert(Person(name: "Name\(i)", phone: "1234-\(i)"), at: i)
                        break
                    }
                }
                DispatchQueue.main.async {
                    self.endTimer = DispatchTime.now()
                    self.timer()
                    self.cell3 = "Element non-existing search time: \(self.resultTime) Result number: \(self.resultNumber)"
                    collectionView.reloadData()
                }
            }
        case 7:
            startTimer = DispatchTime.now()
            dictionary.removeValue(forKey: "Name\(count / 2)")
            queue.async {
                for i in 0..<self.dictionary.count {
                    if (self.dictionary["Name\(i)"] == nil) {
                        self.resultNumber = "1223-\(i)"
                        self.dictionary["Name\(i)"] = String("1223-\(i)")
                        break
                    }
                }
                DispatchQueue.main.async {
                    self.endTimer = DispatchTime.now()
                    self.timer()
                    self.cell6 = "Element non-existing search time: \(self.resultTime) Result number: \(self.resultNumber)"
                    collectionView.reloadData()
                }
            }
        default:
            break
        }
    }
    
    @discardableResult func timer () -> String {
        let nanoTime = endTimer.uptimeNanoseconds - startTimer.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        resultTime = String(format: "%.0f ms.", timeInterval)
        return resultTime
    }
    
}

extension DictionaryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem = collectionView.frame.width / itemsPerRow
        if indexPath.item == 0  {
            return CGSize(width: widthPerItem, height: 80)
        } else {
            return CGSize(width: widthPerItem, height: 80)
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
