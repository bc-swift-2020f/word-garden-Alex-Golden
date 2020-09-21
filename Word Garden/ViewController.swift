//
//  ViewController.swift
//  Word Garden
//
//  Created by Alex Golden on 9/14/20.
//  Copyright © 2020 Alex Golden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsInGameLabel: UILabel!
    @IBOutlet weak var wordBeingRevealedLabel: UILabel!
    @IBOutlet weak var guessedLetterTextField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var gameStatusMessageLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var wordsToGuess = ["SWIFT", "DOG", "CAT"]
    var currentWordIndex = 0
    var wordToGuess = ""
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    var guessCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let text = guessedLetterTextField.text!
       guessLetterButton.isEnabled = !(text.isEmpty)
    wordToGuess = wordsToGuess[currentWordIndex]
        wordBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count-1)
        
        func updateGameStatusLabels() {
            //update labels at top
            wordsGuessedLabel.text = "words guessed: \(wordsGuessedCount)"
            wordsMissedLabel.text = "words missed: \(wordsMissedCount)"
            wordsRemainingLabel.text = "words to guess: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
            wordsInGameLabel.text = "words in game: \(wordsToGuess.count)"
    }
    
    func updateUIAfterGuess() {
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = " "
        guessLetterButton.isEnabled = false
    }
    
    
    func formatRevealedWord() {
        // format and show revealedWord in wordBeingRevealedLabel to include new guess
        
        var revealedWord = ""
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + "\(letter)"
            } else {
                revealedWord = revealedWord + "_ "
            }
        }
        revealedWord.removeLast()
        wordBeingRevealedLabel.text = revealedWord
        
    }
    
    func updateAfterWinOrLose() {
        currentWordIndex += 1
        guessedLetterTextField.isEnabled = false
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = false
        
        updateGameStatusLabels()
        
    }
    
    func guessALetter(){
        //get current letter guessed and add it to letterGuessed
        let currentLetterGuessed = guessedLetterTextField.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed
        //format and show revealedWord in wordBeingRevealedLabel to include new guess
        
        formatRevealedWord()
        
        //update image and keep track of wrongs
        if wordToGuess.contains(currentLetterGuessed) == false {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower \(wrongGuessesRemaining)")
        }
        
        //updategamestatusmessagelabel
        guessCount = guessCount + 1
//        var guesses = "guesses"
//        if guessCount == 1 {
//            guesses = "guess"
//        }
        let guesses = (guessCount == 1 ? "guess" : "guesses")
        gameStatusMessageLabel.text = "You've made \(guessCount) \(guesses)"
    
        
        if wordBeingRevealedLabel.text!.contains("_") == false {
            gameStatusMessageLabel.text = "You've guessed it, it took you \(guessCount) guesses to guess the word"
            wordsGuessedCount += 1
            updateAfterWinOrLose()
        } else if wrongGuessesRemaining == 0 {
            gameStatusMessageLabel.text = "So sorry, You're out of guesses"
            wordsMissedCount += 1
            updateAfterWinOrLose()
        }
        
        
        
    }
    
        func guessedLetterFieldChanged(_ sender: UITextField) {
        sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces)
        guessLetterButton.isEnabled = !(sender.text!.isEmpty)
    }
        func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
        func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
        func playAgainButtonPressed(_ sender: UIButton) {
    }
}

}
