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
    let countCell = 9_999_999
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    var checkTimer = false
    var checkCreateArray = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.delegate = self
        self.collectionView.dataSource = self
        
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
    
//    func startActivityIndicator (_ indexPath: IndexPath) {
//        if checkTimer == false {
//            timer()
//        }
//
//        let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
//        firstCell.activityIndicator.isHidden = false
//        firstCell.firstLabelOutlet.isHidden = true
//        collectionView.reloadData()
//
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        start = DispatchTime.now()
        if indexPath.item == 0 && checkCreateArray == false {
            checkTimer = false
            createArray() {
                collectionView.reloadData()
                self.checkCreateArray = false
            }
        }
    }
    
    
    func createArray (completion: @escaping () -> Void) {
        checkCreateArray = true
        let countArray = countCell/arrayCell.arrayName.count
        let modulo = countCell % arrayCell.arrayName.count
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            if modulo == 0 {
                for _ in 1...countArray {
                    for i in self.arrayCell.arrayName {
                        if self.array.count == 0 {
                            self.array.append("")
                            self.array.append(i)
                        } else if self.array.count != self.countCell + 1 {
                            self.array.append(i)
                        }
                    }
                }
            } else {
                for _ in 1...countArray + 1 {
                    for i in self.arrayCell.arrayName {
                        if self.array.isEmpty {
                            self.array.append("")
                            self.array.append(i)
                        } else if self.array.count != self.countCell + 1 {
                            self.array.append(i)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion()
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
//        var cellSize = CGSize()
//        if indexPath.item == 0 {
//            cellSize = CGSize(width: collectionView.frame.width, height: 80)
//        } else if indexPath.item <= 1000 {
//            cellSize = CGSize(width: widthPerItem, height: 80)
//        } else {
//            let queue = DispatchQueue.global(qos: .background)
//            queue.async {
//                    cellSize = CGSize(width: widthPerItem, height: 80)
//            }
//        }
//        return cellSize
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

