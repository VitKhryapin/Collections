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
    var resultFirstCell: String = "Create Int array with 10_000_000 elements"
    var resultOtherCell  = ""
    var array: Array<Any> = []
    var arrayCell: ArrayCell = ArrayCell()
    var countCell = 2014
    var countCellArray = 0
    var checkCreateArray = false
    var timer = Timer()
    var elapsed = 0.0
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.allowsMultipleSelection = true
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
    Int {
        if array.count == 0 {
            return 1
        } else {
            return array.count
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
            otherCell.otherLabel.text = "\(array[indexPath.item])"
            cell = otherCell
        }
        return cell
    }
    
    
    func startTimer() -> String {
        timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.updateTime), userInfo: NSDate(), repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        return result
    }
    @objc func updateTime() -> String {
        let queue = DispatchQueue.global(qos: .background)
        queue.sync {
            self.elapsed = -(self.timer.userInfo as! NSDate).timeIntervalSinceNow
            DispatchQueue.main.async {
                self.result = String(format: "%.3f ms.", self.elapsed)
            }
        }
        return result
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        let item = indexPath.item % arrayCell.arrayName.count
        if item == 0  {
            startTimer()
            createArray(indexPath) {
                collectionView.reloadData()
                self.resultFirstCell = "Array creation time: \(self.result)"
                self.array[indexPath.item] = self.resultFirstCell
                self.checkCreateArray = false
                print(self.array.count)
            }
        } else {
            switch "\(array[indexPath.item])" {
            case "Insert 1000 elements at the beginning of the array one-by-one":
                startTimer()
                insertElementsBeginningOneByOne {
                    collectionView.reloadData()
                    self.resultOtherCell = "Insertion time: \(self.result)"
                    self.array[indexPath.item] = self.resultOtherCell
                    self.checkCreateArray = false
                    print(self.array.count)
                }
            case "Insert 1000 elements at the beginning of the array":
                startTimer()
                insertElementsBeginningAtOnce {
                    collectionView.reloadData()
                    self.resultOtherCell = "Insertion time: \(self.result)"
                    self.array[indexPath.item] = self.resultOtherCell
                    self.checkCreateArray = false
                    print(self.array.count)
                }
            case "Insert 1000 elements in the middle of the array one-by-one":
                startTimer()
                insertElementsMiddleOneByOne {
                    collectionView.reloadData()
                    self.resultOtherCell = "Insertion time: \(self.result)"
                    self.array[indexPath.item] = self.resultOtherCell
                    self.checkCreateArray = false
                    print(self.array.count)
                }
            case "Insert 1000 elements in the middle of the array":
                startTimer()
                insertElementsMiddleAtOnce {
                    collectionView.reloadData()
                    self.resultOtherCell = "Insertion time: \(self.result)"
                    self.array[indexPath.item] = self.resultOtherCell
                    self.checkCreateArray = false
                    print(self.array.count)
                }
            case "Insert 1000 elements at the end of the array one-by-one":
                startTimer()
                insertElementsEndOneByOne {
                    collectionView.reloadData()
                    self.resultOtherCell = "Insertion time: \(self.result)"
                    self.array[indexPath.item] = self.resultOtherCell
                    self.checkCreateArray = false
                    print(self.array.count)
                }
            case "Insert 1000 elements at the end of the array":
                startTimer()
                insertElementsEndAtOnce {
                    collectionView.reloadData()
                    self.resultOtherCell = "Insertion time: \(self.result)"
                    self.array[indexPath.item] = self.resultOtherCell
                    self.checkCreateArray = false
                    print(self.array.count)
                }
            case "Remove 1000 elements at the beginning of the array one-by-one":
                    startTimer()
                    removeElementsBeginningOneByOne {
                        collectionView.reloadData()
                        self.resultOtherCell = "Remove time: \(self.result)"
                        if indexPath.item > 7 {
                            self.array[indexPath.item] = self.resultOtherCell
                        }
                        self.checkCreateArray = false
                        print(self.array.count)
                    }
//            case "Remove 1000 elements at the beginning of the array":
//                startTimer()
//                removeElementsBeginningOnce {
//                    collectionView.reloadData()
//                    self.resultOtherCell = "Remove time: \(self.result)"
//                    if indexPath.item > 7 {
//                        self.array[indexPath.item] = self.resultOtherCell
//                    }
//                    self.checkCreateArray = false
//                    print(self.array.count)
//                }
            default:
                break
            }
        }
    }
    
    func createArray (_ indexPath: IndexPath, completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            array.removeAll()
            countCellArray = countCell
            var countArray = countCellArray/arrayCell.arrayName.count
            let modulo = countCellArray % arrayCell.arrayName.count
            let queue = DispatchQueue.global(qos: .background)
            if modulo != 0 {
                countArray += 1
            }
            queue.async {
                for _ in 1...countArray {
                    for i in self.arrayCell.arrayName {
                        if self.array.count == 0 {
                            self.array.append("")
                            self.array.append(i)
                        } else if self.array.count <= self.countCellArray {
                            self.array.append(i)
                        } else {
                            break
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsBeginningOneByOne (completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            countCellArray += 1000
            var insertPoint = 1
            var countArray = 1000/arrayCell.arrayName.count
            let modulo = 1000 % arrayCell.arrayName.count
            if modulo != 0 {
                countArray += 1
            }
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                for _ in 1...countArray {
                    for i in self.arrayCell.arrayName {
                        if self.array.count <= self.countCellArray {
                            self.array.insert(i, at: insertPoint)
                            insertPoint += 1
                        } else {
                            break
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsBeginningAtOnce (completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            countCellArray += 1000
            let insertPoint = 1
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                self.array.insert(contentsOf: self.array[1...1000], at: insertPoint)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsMiddleOneByOne (completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            var insertPoint = countCellArray/2
            countCellArray += 1000
            var countArray = 1000/arrayCell.arrayName.count
            let modulo = 1000 % arrayCell.arrayName.count
            if modulo != 0 {
                countArray += 1
            }
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                for _ in 1...countArray {
                    for i in self.arrayCell.arrayName {
                        if self.array.count <= self.countCellArray {
                            self.array.insert(i, at: insertPoint)
                            insertPoint += 1
                        } else {
                            break
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsMiddleAtOnce (completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            var insertPoint = countCellArray/2
            countCellArray += 1000
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                self.array.insert(contentsOf: self.array[1...1000], at: insertPoint)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsEndOneByOne (completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            countCellArray += 1000
            var countArray = 1000/arrayCell.arrayName.count
            let modulo = 1000 % arrayCell.arrayName.count
            if modulo != 0 {
                countArray += 1
            }
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                for _ in 1...countArray {
                    for i in self.arrayCell.arrayName {
                        if self.array.count <= self.countCellArray {
                            self.array.insert(i, at: self.array.count)
                        } else {
                            break
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func insertElementsEndAtOnce (completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            countCellArray += 1000
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                self.array.insert(contentsOf: self.array[1...1000], at: self.array.count)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func removeElementsBeginningOneByOne (completion: @escaping () -> Void) {
        if checkCreateArray == false && array.count > 1001 {
            checkCreateArray = true
            countCellArray -= 1000
            var insertPoint = 1001
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                for _ in 1...1000 {
                    if self.array.count >= self.countCellArray {
                        self.array.remove(at: insertPoint)
                        insertPoint -= 1
                    } else {
                        break
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            array.removeAll()
            collectionView.reloadData()
        }
    }
    func removeElementsBeginningOnce (completion: @escaping () -> Void) {
        if checkCreateArray == false && array.count > 1001 {
            checkCreateArray = true
            countCellArray -= 1000
            var insertPoint = 1001
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                    if self.array.count >= self.countCellArray {
                        //self.array.remove(at: 1000)
                        self.array.removeFirst(1000)
                        insertPoint -= 1
                    }
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            array.removeAll()
            collectionView.reloadData()
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



//    func timer (_ indexPath: IndexPath) -> String {
//        let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
//        let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionViewCell", for: indexPath) as! OtherCollectionViewCell
//
//        if indexPath.item == 0 && array.count != 0 {
//            let nanoTime = firstCell.end.uptimeNanoseconds - firstCell.start.uptimeNanoseconds
//            let timeInterval = Double(nanoTime) / 1_000_000_000
//            resultFirstCell = String(format: "Array creation time %.3f ms.", timeInterval)
//            checkTimer = true
//            return resultFirstCell
//        } else {
//            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
//            let timeInterval = Double(nanoTime) / 1_000_000_000
//            resultOtherCell = String(format: "Insert %.3f ms.", timeInterval)
//            checkTimer = true
//            return resultOtherCell
//        }
//    }
