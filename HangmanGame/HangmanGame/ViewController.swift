//
//  ViewController.swift
//  HangmanGame
//
//  Created by CANSU ARAR on 22.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var wordsArray = [String]()
    
    @IBOutlet weak var wordLabel: UILabel!
    
    var tempWord = ""
    var usedLetters = String()
    var wrongAnswers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordLabel.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(fetchData))
        
        
    }
    
    
    @objc func fetchData() {
        
        if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let word = try? String(contentsOf: wordsURL) {
                DispatchQueue.main.async { [weak self] in
                    self?.wordsArray = word.components(separatedBy: "\n")
                    guard let word = self?.wordsArray.randomElement() else { return }
                    self?.tempWord = word
                    self?.startGame()
                }
            }
        }
    }
    
    
    func startGame() {
        let ac = UIAlertController(title: "Guess a letter", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        
        let submitAction = UIAlertAction(title: "guess a letter ", style: .default, handler: {
            [weak self] action in
            guard let input = ac.textFields?[0].text else { return }
            self?.usedLetters.append(input)
            self?.submit(input)
        })
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ input : String) {
        var promptWord = ""
        var harf = promptWord
        while wrongAnswers < 5 {
            for letter in tempWord {
                let strLetter = String(letter)
                
                if usedLetters.contains(strLetter) {
                    promptWord += strLetter
                } else {
                    promptWord += "?"
                }
            }
            
            startGame()
            wrongAnswers += 1
            
            wordLabel.isHidden = false
            wordLabel.text = promptWord
        }
        
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 1 {
            textField.text = String(text.prefix(1)) // get only first character
        }
    }
    
}




