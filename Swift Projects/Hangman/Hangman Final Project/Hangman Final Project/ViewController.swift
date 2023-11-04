//
//  ViewController.swift
//  Hangman Final Project
//
//  Created by Dylan K. Stewart on 4/28/22.
//  Copyright © 2022 Dylan K. Stewart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayWordLabel: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var hangmanImage: UIImageView!
    
    
    
    //These are the words people will try to complete by guessing
    var wordArray = ["SHIELD", "JUICE", "COOKIE", "APPLE", "AFFIX", "AVENUE", "AWKWARD", "BEEKEEPER", "BOGGLE", "COBWEB", "CYCLE", "EQUIP","EXODUS", "GALAXY", "ICEBOX", "KIOSK"]
    
    //This is the randomly chosen word from the wordArray
    var word = ""
    
    //This is where I determine if the game has ended SO THE USER CANNOT CRASH MY GAME
    var GAMECONDITION:Bool = false
    
    // This is where I hold the wrong guesses
    var wrongLettersArray = [Character]()
    
    //This is where I store the letters used in the word
    var usedLetters = [Character]()
    
    //This is where I display letters and question marks of the word trying to be guessed
    var displayWordArray = [Character]()
    
    //This is the string I display for the user to guess
    var displayWord = ""
    
    //This is the character that the user guesses
    var guess: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //choose the word and assign to variable word
        let randomIndex = Int(arc4random_uniform(UInt32(wordArray.count)))
        word = wordArray[randomIndex]
        
        usedLetters = Array(word)
        //set displayWord to the right number of question marks and put into diaplay word label
        for letter in 1...word.count{
            
            displayWord += "?"
            
            displayWordLabel.text = displayWord
            displayWordArray = Array(displayWord)
        }
    }
    
    
    
    @IBAction func guessButton(_ sender: UIButton) {
        if (GAMECONDITION == true) { // STOPS USER FROM CRASHING THE GAME AFTER GAME IS COMPLETE
            return
        }
        //Resign first responder textField
        guessTextField.resignFirstResponder() // Makes keyboard disappear
        guessTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter a letter",
            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white]
        )

        //Make sure the user has entered a letter but only one letter
        let guess1 = guessTextField.text
        var AlphabetArray:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        if guess1 == ""{
            //guessTextField.placeholder = "Enter a letter"
            guessTextField.attributedPlaceholder = NSAttributedString(
                string: "Enter a letter",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.white]
            )
            return
        }
        if guess1!.count > 1 {
            //guessTextField.placeholder = "Enter one letter"
            guessTextField.text = ""
            guessTextField.attributedPlaceholder = NSAttributedString(
                string: "Enter one letter",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.white]
            )
            return
        } else if !AlphabetArray.contains(guess1!.capitalized){ // PREVENTS NON-ALPHABETICAL CHARACTERS BEING ENTERED AS A GUESS
                guessTextField.text = ""
                guessTextField.attributedPlaceholder = NSAttributedString(
                    string: "Must be a letter",
                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
                return
        } else {
            if guessTextField.text != "" { //  IMPLEMENTED TO DUMPSTER NIL VALUES
                guess = Character(guessTextField.text!.capitalized) // makes everything capitalized so its easier
            }
            
            for item in wrongLettersArray{ // CHECK IF USER MAKES A NEW GUESS OR NOT
                if (item == guess){
                    guessTextField.text = ""
                    guessTextField.attributedPlaceholder = NSAttributedString(
                        string: "Enter a new guess",
                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.white]
                    )
                    return
                }
            }
        
            //Call the check for letter function
            checkForLetter()
            displayWord = String(displayWordArray)
            displayWordLabel.text = displayWord
            guessTextField.text = ""
            checkForWin()
        }
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        //Reset the variables, the labels, the images
        guessTextField.text = ""
        hangmanImage.image = UIImage(named: "0")
        gameImage.image = UIImage(contentsOfFile: "")
        wrongLettersArray = []
        wrongLetters.text = ""
        displayWord = ""
        GAMECONDITION = false
        
        
        let randomIndex2 = Int(arc4random_uniform(UInt32(wordArray.count)))
        word = wordArray[randomIndex2]
        //Pick a new random word and display it in the label
        word = wordArray[randomIndex2]
        usedLetters = Array(word)
        
        for letters in 1...word.count {
            
            displayWord += "?"
            displayWordLabel.text = displayWord
            displayWordArray = Array(displayWord)
        }
        
    }
    
    func checkForLetter() { // CHECKS AGAINST THE ACTUAL WORD FOR ANY SPOTS
        guard (guess) != nil  else{
        return
        }
        if usedLetters.contains(guess) {
            for i in 0...word.count - 1 {
                if guess == usedLetters[i]{
                    
                    displayWordArray[i] = guess
                }
            }
        }
        
        else {
            wrongLettersArray.append(guess)
            wrongLetters.text = String(wrongLettersArray)
            placeImage()
            return
        }
        
    }
    
    func placeImage() { // This is where I make my HANGMAN
        let p1 = UIImage(named: "1")
        let p2 = UIImage(named: "2")
        let p3 = UIImage(named: "3")
        let p4 = UIImage(named: "4")
        let p5 = UIImage(named: "5")
        let p6 = UIImage(named: "6")
        let p7 = UIImage(named: "7")
        let p8 = UIImage(named: "8")
        let p9 = UIImage(named: "9")
        let p10 = UIImage(named: "10")
        
        let imageArray = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]
        
        hangmanImage.image = imageArray[wrongLettersArray.count-1]
    }
    
    func checkForWin() { // This is where I check for win and let the user know where or not they win or lose
        if wrongLettersArray.count == 10 {
            
            gameImage.image = UIImage(named: "gameOver")
            displayWordLabel.text = word // CASE THE USER LOSES BUT STILL WANTS TO SEE THE WORD
            GAMECONDITION = true
        } else if displayWord.contains("?") {
            return
        } else {
            gameImage.image = UIImage(named: "youWin")
            GAMECONDITION = true
            return
        }
    }
    
    
}



