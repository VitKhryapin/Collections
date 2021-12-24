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
    var arrayCell: ArrayCell = ArrayCell()
    var countCell = 300000
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    var checkTimer = false
    var checkCreateArray = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.delegate = self
        self.collectionView.dataSource = self
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
        end = DispatchTime.now()
        
        if checkTimer == false {
            timer()
        }
        if indexPath.item == 0 {
            firstCell.firstLabelOutlet.text = result
            cell = firstCell
        } else {
            otherCell.otherLabel.text  = "\(array[indexPath.item])"
            cell = otherCell
        }
        return cell
    }
    
    
    
    func timer () -> String {
        if array.count != 0 {
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            result = String(format: "Array creation time %.3f ms.", timeInterval)
            checkTimer = true
            return result
        } else {
            return result
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        //        let otherCell = collectionView.cellForItem(at: indexPath) as? OtherCollectionViewCell
        
        let item = indexPath.item % arrayCell.arrayName.count
        print(indexPath.item)
        start = DispatchTime.now()
        if item == 0 && checkCreateArray == false {
            checkTimer = false
            createArray(indexPath) {
                collectionView.reloadData()
                self.checkCreateArray = false
                print(self.array.count)
            }
        } else if item == 1 {
            insertElementsBeginningOneByOne {
                collectionView.reloadData()
                self.checkCreateArray = false
                print(self.array.count)
            }
        }
    }
    
    func createArray (_ indexPath: IndexPath, completion: @escaping () -> Void) {
        if checkCreateArray == false {
            checkCreateArray = true
            array.removeAll()
            countCell = 300000
            var countArray = countCell/arrayCell.arrayName.count
            let modulo = countCell % arrayCell.arrayName.count
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
                        } else if self.array.count <= self.countCell {
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
            countCell += 1000
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
                        if self.array.count <= self.countCell {
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


//    func startTimer() {
//
//        timer?.invalidate()
//
//            self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.updateTime), userInfo: NSDate(), repeats: true)
//        RunLoop.current.add(timer!, forMode: .common)
//        //queue.async {
//
//    }
//    @objc func updateTime() -> String {
////        let queue = DispatchQueue.global(qos: .userInteractive)
////        queue.sync {
//            self.elapsed = -(self.timer?.userInfo as! NSDate).timeIntervalSinceNow
////            DispatchQueue.main.async {
//                self.result = String(format: "Array creation time %.3f ms.", self.elapsed)
//        print ("tik")
////            }
////        }
//        return result
//    }

