//
//  ArrayCollectionViewController.swift
//  Collections
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import UIKit


class ArrayCollectionViewController: UICollectionViewController {
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var resultFirstCell: String = "Create Int array with 10_000_000 elements"
    var resultOtherCell  = ""
    var array: Array<Any> = []
    var arrayCell: ArrayCell = ArrayCell()
    var arrayNameCell: Array<Any> = []
    var countCell = 10_000_000
    var countCellArray = 0
    var checkCreateArray = false
    var elapsed = 0.0
    var result = ""
    var startTimer = DispatchTime.now()
    var endTimer = DispatchTime.now()
    let queue = DispatchQueue.global(qos: .background)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView?.allowsMultipleSelection = true
        arrayNameCell = arrayCell.arrayName
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
    Int {
        if array.count == 0 {
            return 1
        } else {
            return (1 + arrayCell.arrayName.count)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionViewCell", for: indexPath) as! OtherCollectionViewCell
        var cell = UICollectionViewCell()
        firstCell.layer.borderWidth = 0.5
        otherCell.layer.borderWidth = 0.5
        if indexPath.item == 0 {
            firstCell.firstLabelOutlet.text = resultFirstCell
            cell = firstCell
        } else {
            otherCell.otherLabel.text = "\(arrayNameCell[indexPath.item - 1])"
            cell = otherCell
        }
        return cell
    }
    
    @discardableResult func timer () -> String {
        let nanoTime = endTimer.uptimeNanoseconds - startTimer.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        result = String(format: "%.3f ms.", timeInterval)
        return result
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            checkCreateArray = false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        
        switch indexPath.item {
        case 0: // create array
            startTimer = DispatchTime.now()
            createArray() {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.resultFirstCell = "Array creation time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 1: //"Insert 1000 elements at the beginning of the array one-by-one"
            startTimer = DispatchTime.now()
            insertElementsBeginningOneByOne {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Insertion time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 2: //"Insert 1000 elements at the beginning of the array"
            startTimer = DispatchTime.now()
            insertElementsBeginningAtOnce {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Insertion time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 3: //"Insert 1000 elements in the middle of the array one-by-one"
            startTimer = DispatchTime.now()
            insertElementsMiddleOneByOne {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Insertion time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 4: //"Insert 1000 elements in the middle of the array"
            startTimer = DispatchTime.now()
            insertElementsMiddleAtOnce {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Insertion time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 5: //"Insert 1000 elements at the end of the array one-by-one"
            startTimer = DispatchTime.now()
            insertElementsEndOneByOne {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Insertion time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 6: //"Insert 1000 elements at the end of the array"
            startTimer = DispatchTime.now()
            insertElementsEndAtOnce {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1]  = "Insertion time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 7: //"Remove 1000 elements at the beginning of the array one-by-one"
            startTimer = DispatchTime.now()
            removeElementsBeginningOneByOne {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Remove time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 8: //"Remove 1000 elements at the beginning of the array"
            startTimer = DispatchTime.now()
            removeElementsBeginningOnce {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Remove time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 9: //"Remove 1000 elements in the middle of the array one-by-one"
            startTimer = DispatchTime.now()
            removeElementsMiddleOneByOne {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Remove time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 10: //"Remove 1000 elements in the middle of the array"
            startTimer = DispatchTime.now()
            removeElementsMiddleOnce {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Remove time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 11: //"Remove 1000 elements at the end of the array one-by-one"
            startTimer = DispatchTime.now()
            removeElementsEndOneByOne {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Remove time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        case 12: //"Remove 1000 elements at the end of the array"
            startTimer = DispatchTime.now()
            removeElementsEndOnce {
                collectionView.reloadData()
                self.endTimer = DispatchTime.now()
                self.timer()
                self.arrayNameCell[indexPath.item - 1] = "Remove time: \(self.result)"
                self.checkCreateArray = false
                print(self.array.count)
            }
        default:
            break
        }
    }
    
    func createArray (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        array.removeAll()
        arrayNameCell = arrayCell.arrayName
        countCellArray = countCell
        queue.async {
            for i in 0...self.countCellArray - 1 where self.checkCreateArray == true {
                self.array.append(i)
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsBeginningOneByOne (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        countCellArray += 1000
        queue.async {
            for i in 0...999 where self.checkCreateArray == true {
                self.array.insert(i, at: self.array.startIndex)
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsBeginningAtOnce (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        countCellArray += 1000
        queue.async {
            let arrayOneThousand = Array (0...999)
            self.array.insert(contentsOf: arrayOneThousand, at: self.array.startIndex)
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsMiddleOneByOne (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        let insertPoint = countCellArray/2
        countCellArray += 1000
        queue.async {
            for i in 0...999 where self.checkCreateArray == true {
                self.array.insert(i, at: insertPoint)
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsMiddleAtOnce (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        let insertPoint = countCellArray/2
        countCellArray += 1000
        queue.async {
            let arrayOneThousand = Array (0...999)
            self.array.insert(contentsOf: arrayOneThousand, at: insertPoint)
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsEndOneByOne (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        countCellArray += 1000
        queue.async {
            for i in 0...999 where self.checkCreateArray == true {
                self.array.append(i)
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        
    }
    
    func insertElementsEndAtOnce (completion: @escaping () -> Void) {
        guard !checkCreateArray else { return }
        checkCreateArray = true
        countCellArray += 1000
        queue.async {
            let arrayOneThousand = Array (0...999)
            self.array.append(contentsOf: arrayOneThousand)
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func removeElementsBeginningOneByOne (completion: @escaping () -> Void) {
        guard !checkCreateArray && array.count >= 1000 else { return }
        checkCreateArray = true
        countCellArray -= 1000
        queue.async {
            for _ in 0...999 where self.checkCreateArray == true  {
                self.array.remove(at: self.array.startIndex)
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    func removeElementsBeginningOnce (completion: @escaping () -> Void) {
        guard !checkCreateArray && array.count >= 1000 else { return }
        checkCreateArray = true
        countCellArray -= 1000
        queue.async {
            self.array.removeFirst(1000)
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    func removeElementsMiddleOneByOne (completion: @escaping () -> Void) {
        guard !checkCreateArray && array.count >= 1000 else { return }
        checkCreateArray = true
        let insertPoint = countCellArray/2
        countCellArray -= 1000
        queue.async {
            for _ in 0...999 where self.checkCreateArray == true {
                self.array.remove(at: insertPoint)
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    func removeElementsMiddleOnce (completion: @escaping () -> Void) {
        guard !checkCreateArray && array.count >= 1000 else { return }
        checkCreateArray = true
        let insertPoint = countCellArray/2
        countCellArray -= 1000
        queue.async {
            self.array.removeSubrange(insertPoint...insertPoint+999)
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    func removeElementsEndOneByOne (completion: @escaping () -> Void) {
        guard !checkCreateArray && array.count >= 1000 else { return }
        checkCreateArray = true
        countCellArray -= 1000
        queue.async {
            for _ in 0...999 where self.checkCreateArray == true {
                self.array.removeLast()
            }
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    func removeElementsEndOnce (completion: @escaping () -> Void) {
        guard !checkCreateArray && array.count >= 1000 else { return }
        checkCreateArray = true
        countCellArray -= 1000
        queue.async {
            self.array.removeLast(1000)
            if self.array.count == self.countCellArray {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}



extension ArrayCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem = collectionView.frame.width / itemsPerRow
        
        if indexPath.item == 0  {
            return CGSize(width: collectionView.frame.width, height: 80)
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




