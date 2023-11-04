//
//  ViewController.swift
//  Project 3 Memory Match
//
//  Created by Dylan K. Stewart on 4/24/22.
//  Copyright © 2022 Dylan K. Stewart. All rights reserved.
//
 
import UIKit
 
class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
 
    // Need a function to determine which card
 
// Need a function to stop the card from reflipping after its matched
    var actualMovesMade:Int = 0
    var initializer:Int = 0
    var lastTag:Int = -1
    let GP = gameplay()
    
    var tagArray:[Int] = []
    
    
    
    var prevUIButton:[UIButton] = []
 
    var toFlip:UIButton = UIButton()
    
    
    var toFlipTwo:UIButton = UIButton()
    
    var buttonWinArray:[UIButton] = []
    
    var oldButton:UIButton = UIButton()
     
    @IBAction func btnClick(_ sender: UIButton) {
        //print(GP.winArray)
        
        if(!(lblMovesLeft.text=="0")){
        if(buttonWinArray.contains(sender)==false && toFlip.isEqual(sender)==false && toFlipTwo.isEqual(sender)==false && sender.isEqual(oldButton)==false ) {
        
        prevUIButton.append(sender)
        tagArray.append(sender.tag)
        
        if (initializer == 0){
            initializer += 1
            GP.Scrambler()
        }
        //var winArray: [gameplay.Node] // USED FOR KEEPING TRACK OF A FULL ARRAY OF CARDS INDICATING A WIN?
        var newLabel: String
        var image: UIImage
        //actualMovesMade += 1
 
        if let movesString = lblMovesMade.text{
            actualMovesMade += 1
            if (actualMovesMade == 2) {
            var movesMade = Int(movesString)!
            movesMade += 1
            lblMovesMade.text = String(movesMade)
            lblMovesLeft.text="\(Int(lblMovesLeft.text!)!-1)"
            actualMovesMade = 0
            lastTag = sender.tag
            }
        }
 
        if let label = sender.titleLabel!.text{
            newLabel = label
        } else {
            newLabel = " " // if optional binding fails
        }
 
        if newLabel != " "  { // IF IMAGE NOT DOGGO
                image = UIImage(named: "dog")!
                newLabel = " "
            } else {
                image = UIImage()
                //newLabel = "Hello"
            newLabel = (GP.getEmoji(sender.tag)).emoji
        }
        sender.setTitle(newLabel, for: .normal)
        sender.setImage(image,for:.normal)
        
        if (tagArray.count%2==0 && tagArray.count>1) {
            
            
            let isMatch = GP.IsMatch(tagArray[tagArray.count-1], tagArray[tagArray.count-2])
            var node1 = GP.getEmoji(tagArray[tagArray.count-1])
            var node2 = GP.getEmoji(tagArray[tagArray.count-2])
            var prevButton = prevUIButton[prevUIButton.count-2]
            var currentButton = sender
            
            if(isMatch){ //this is where we compare
                
                node1.matched = true
                node2.matched = true
                
                GP.matchMade()
                GP.winArray.append(node1)
                GP.winArray.append(node2)
                
                buttonWinArray.append(currentButton)
                buttonWinArray.append(prevButton)
                
            } else {
            
                toFlip=currentButton
                toFlipTwo=prevButton
                
                
            }
            
        }
        
        
        if (tagArray.count%2==1 && tagArray.count>1){
                
            var toFlipWin=false
            var toFlipTwoWin=false
            
            for i in buttonWinArray{
                if(toFlip.isEqual(i)){
                    toFlipWin=true
                }
                if(toFlipTwo.isEqual(i)){
                    toFlipTwoWin=true
                }
            }
            
            if(!toFlipTwoWin){
            //flips both buttons back if they no match
            
            toFlipTwo.setImage(UIImage(named:"dog"), for: .normal)
            
            
            toFlipTwo.setTitle(" ", for: .normal)
                
            toFlipTwo=UIButton()
                
                
            }
            if(!toFlipWin){
                toFlip.setImage(UIImage(named:"dog"), for: .normal)
                toFlip.setTitle(" ", for: .normal)
                toFlip=UIButton()
            }
                
        }
        }
        oldButton=sender
        if(GP.checkWin()){
            lblGame.text="You WIN!!!!!!"
        }
            if(lblMovesLeft.text=="0"){
                lblGame.text="You LOSE !!!!!! 🥶🥶"
            }
        }
        
    }
    @IBOutlet weak var lblGame: UILabel!
    @IBOutlet weak var lblMovesMade: UILabel!
    @IBOutlet weak var lblMovesLeft: UILabel!
    
    
    
 
}
