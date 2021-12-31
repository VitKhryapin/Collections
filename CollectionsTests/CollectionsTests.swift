//
//  CollectionsTests.swift
//  CollectionsTests
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import XCTest
@testable import Collections

class CollectionsTests: XCTestCase {
    
    var arrayCV: ArrayCollectionViewController!
    var setCV: SetViewController!
    var dictionaryCV: DictionaryCollectionViewController!
    
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        arrayCV = storyboard.instantiateViewController(withIdentifier: "ArrayCollectionViewController") as? ArrayCollectionViewController
        arrayCV.loadViewIfNeeded()
        setCV = storyboard.instantiateViewController(withIdentifier: "SetViewController") as? SetViewController
        setCV.loadViewIfNeeded()
        dictionaryCV = storyboard.instantiateViewController(withIdentifier: "DictionaryCollectionViewController") as? DictionaryCollectionViewController
        dictionaryCV.loadViewIfNeeded()
        self.dictionaryCV.count = 10_000
    }
    
    override func tearDownWithError() throws {
        arrayCV = nil
        setCV = nil
        dictionaryCV = nil
    }
    
    func testCreateArray() throws {
        let result = 10_000_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.createArray () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testInsertElementsBeginningOneByOne() throws {
        let result = 1_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.insertElementsBeginningOneByOne () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testInsertElementsBeginningAtOnce() throws {
        let result = 1_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.insertElementsBeginningAtOnce () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testInsertElementsMiddleOneByOne() throws {
        let result = 1_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.insertElementsMiddleOneByOne () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testInsertElementsMiddleAtOnce() throws {
        let result = 1_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.insertElementsMiddleAtOnce () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testInsertElementsEndOneByOne() throws {
        let result = 1_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.insertElementsEndOneByOne () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testInsertElementsEndAtOnce() throws {
        let result = 1_000
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.insertElementsEndAtOnce () {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testRemoveElementsBeginningOneByOne() throws {
        let result = 0
        self.arrayCV.countCellArray = 1000
        arrayCV.array = Array(0...999)
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.removeElementsBeginningOneByOne () {
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testRemoveElementsBeginningOnce() throws {
        let result = 0
        self.arrayCV.countCellArray = 1000
        self.arrayCV.array = Array(0...999)
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.removeElementsBeginningOnce () {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testRemoveElementsMiddleOneByOne() throws {
        let result = 1000
        self.arrayCV.countCellArray = 2000
        self.arrayCV.array = Array(0...1999)
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.removeElementsMiddleOneByOne () {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testRemoveElementsMiddleOnce() throws {
        let result = 1000
        self.arrayCV.countCellArray = 2000
        self.arrayCV.array = Array(0...1999)
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.removeElementsMiddleOnce () {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testRemoveElementsEndOneByOne() throws {
        let result = 0
        self.arrayCV.countCellArray = 1000
        self.arrayCV.array = Array(0...999)
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.removeElementsEndOneByOne () {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testRemoveElementsEndOnce () throws {
        let result = 0
        self.arrayCV.countCellArray = 1000
        self.arrayCV.array = Array(0...999)
        let expectation = expectation(description: "Expectation in " + #function)
        arrayCV.removeElementsEndOnce  () {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            if error != nil {
                XCTFail()
            }
            XCTAssertEqual(self.arrayCV.array.count, result)
        }
    }
    
    func testTextFieldIsNotNumber () throws {
        //Given
        setCV.inputTF.text = "qw12erwr"
        setCV.exceptionTF.text = "qw123"
        let resultInputTF = "qwerwr"
        let resultExceptionTF = "qw"
        //When
        setCV.changedFirstTF(setCV.inputTF)
        setCV.changedSecondTF(setCV.exceptionTF)
        //Then
        XCTAssertEqual(resultInputTF, setCV.inputTF.text)
        XCTAssertEqual(resultExceptionTF, setCV.exceptionTF.text)
    }
    
    func testCreate() throws {
        let result = 10_000
        dictionaryCV.create () {
        }
        sleep(1)
        XCTAssertEqual(self.dictionaryCV.array.arrayName.count, result)
        XCTAssertEqual(self.dictionaryCV.dictionary.count, result)
    }
    
    
    
    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
