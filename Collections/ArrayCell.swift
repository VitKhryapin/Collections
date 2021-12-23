//
//  ArrayCell.swift
//  Collections
//
//  Created by Vitaly Khryapin on 11.12.2021.
//

import Foundation
import UIKit

struct Cell {
    var name: String
}


class ArrayCell {
    var arrayName: Array <Any> = []
    init() {
        setup()
    }
    
    func setup() {
        let cell1 = "Insert 1000 elements at the beginning of the array one-by-one"
        let cell2 = "Insert 1000 elements at the beginning of the array"
        let cell3 = "Insert 1000 elements in the middle of the array one-by-one"
        let cell4 = "Insert 1000 elements in the middle of the array"
        let cell5 = "Insert 1000 elements at the end of the array one-by-one"
        let cell6 = "Insert 1000 elements at the end of the array"
        let cell7 = "Remove 1000 elements at the beginning of the array one-by-one"
        let cell8 = "Remove 1000 elements at the beginning of the array"
        let cell9 = "Remove 1000 elements in the middle of the array one-by-one"
        let cell10 = "Remove 1000 elements in the middle of the array"
        let cell11 = "Remove 1000 elements at the end of the array one-by-one"
        let cell12 = "Remove 1000 elements at the end of the array"
        self.arrayName = [cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9, cell10, cell11, cell12]
        
    }
}
