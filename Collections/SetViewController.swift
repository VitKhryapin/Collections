//
//  SetViewController.swift
//  Collections
//
//  Created by Vitaly Khryapin on 29.12.2021.
//

import UIKit

class SetViewController: UIViewController {
    
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var exceptionTF: UITextField!
    @IBOutlet weak var allMatchesButtonOutlet: UIButton!
    @IBOutlet weak var firstResult: UILabel!
    @IBOutlet weak var allDoNotMatchesButtonOutlet: UIButton!
    @IBOutlet weak var secondResult: UILabel!
    @IBOutlet weak var uniqCharactersButtonOutlet: UIButton!
    @IBOutlet weak var thirdResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        identifier()
    }
    
    func identifier () {
        inputTF.accessibilityIdentifier = "inputTF"
        exceptionTF.accessibilityIdentifier = "exceptionTF"
        firstResult.accessibilityIdentifier = "firstResult"
        secondResult.accessibilityIdentifier = "secondResult"
        thirdResult.accessibilityIdentifier = "thirdResult"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func selectedAllMatches () {
        guard let inputString: String = inputTF.text else { return }
        guard let exceptionString: String = exceptionTF.text  else { return }
        let exceptionCharacters = Set(exceptionString.compactMap{$0})
        let inputCharacters = Set(inputString.compactMap{$0})
        var result = Set <Character>()
        result = inputCharacters.intersection(exceptionCharacters)
        firstResult.text = String(result)
    }
    
    func selectedDoNotMatches () {
        guard let inputString: String = inputTF.text else { return }
        guard let exceptionString: String = exceptionTF.text  else { return }
        let exceptionCharacters = exceptionString.compactMap{$0}
        let inputCharacters = inputString.compactMap{$0}
        let notMatchingWithInpuCharacters = inputCharacters
            .filter{!exceptionCharacters.contains($0)}
            .compactMap{$0}
        let notMatchingWithExceptionCharacters = exceptionCharacters
            .filter{!inputCharacters.contains($0)}
            .compactMap{$0}
        secondResult.text = "\(String(Set(notMatchingWithInpuCharacters + notMatchingWithExceptionCharacters)))"
    }
    
    func selectedAllDoNotMatches () {
        guard let inputString: String = inputTF.text else { return }
        guard let exceptionString: String = exceptionTF.text  else { return }
        let exceptionCharacters = Set(exceptionString.compactMap{$0})
        let inputCharacters = Set(inputString.compactMap{$0})
        var result = Set <Character>()
        result = inputCharacters.subtracting(exceptionCharacters)
        thirdResult.text = String(result)
    }
    
    
    
    @IBAction func changedFirstTF(_ sender: UITextField) {
        if let lastSymbol = sender.text?.last {
            if !lastSymbol.isLetter {
                sender.text?.removeLast()
            }
        }
        if let text = sender.text {
            sender.text = text.filter{$0.isLetter}
        }
    }
    @IBAction func changedSecondTF(_ sender: UITextField) {
        if let lastSymbol = sender.text?.last {
            if !lastSymbol.isLetter {
                sender.text?.removeLast()
            }
        }
        if let text = sender.text {
            sender.text = text.filter{$0.isLetter}
        }
    }
    
    @IBAction func allMatchesAction(_ sender: Any) {
        selectedAllMatches()
    }
    
    @IBAction func allCharectersAction(_ sender: Any) {
        selectedDoNotMatches ()
    }
    
    @IBAction func uniqCharactersAction(_ sender: Any) {
        selectedAllDoNotMatches ()
    }
    
}


