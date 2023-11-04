//
//  gameplay.swift
//  Project 3 Memory Match
//
//  Created by Dylan K. Stewart on 4/28/22.
//  Copyright © 2022 Dylan K. Stewart. All rights reserved.
//
 
import UIKit
 
class gameplay{
 
    var winArray:[gameplay.Node] = []
    
    
    var matchesLeft=10
    
    
    func memoryMatch(){
    Scrambler()
 
 
    }
 
 
    struct Node {
        var emoji:String // string for the emoji symbol
        var matched:Bool // indicates if two cards have matched
        init(emoji: String, matched: Bool){
            self.emoji = emoji
            self.matched = matched
        }
    }
    var emojiArray : [[Node]] = [] // USED TO CONTAIN 10 RANDOM EMOJI CHARACTERS FOR THE BOARD
    var scramble : [String] = ["😊", "❤️", "🙏", "🤑", "💀", "🔥", "🤔", "🤣", "😂", "🌸","😊", "❤️", "🙏", "🤑", "💀", "🔥", "🤔", "🤣", "😂", "🌸"]
 
    func Scrambler(){ // MAKES MY 2D ARRAY SCRAMBLED
        // NO NEED FOR SEARCH FUNCTION
        var someNode:Node
        var randomEmoji:String
        var randomEmoji_Index: Int
        /*for i in 0...4{ // 5 ROWS
            for j in 0...3{ // EACH HAVE 4 COLUMNS
                    let randomEmoji_Index = Int(arc4random_uniform(UInt32(scramble.count-1)))
                    let randomEmoji = scramble[randomEmoji_Index]
 
                        someNode = Node(emoji: randomEmoji, matched: false)
                        scramble.remove(at: randomEmoji_Index)
                        emojiArray[i][j] = someNode
            }
        }*/
         for i in 0...scramble.count-1{
             let randomEmoji_Index = Int(arc4random_uniform(UInt32(scramble.count-1)))
             let randomEmoji = scramble[randomEmoji_Index]

             someNode = Node(emoji: randomEmoji, matched: false)
             scramble.remove(at: randomEmoji_Index)
             emojiArray.append([someNode])
             
             
    }
         
}
 
    func printf(_ variable: Any){ // USED FOR DEBUGGING MY CLASS
        print(variable)
    }
 
    func getEmoji(_ tag: Int)->Node{ // RETURNS ONE NODE
        let translator = translate(tag)
        let oneNode = emojiArray[tag][0]
        return oneNode
    }
 
    func translate(_ tag : Int)->(row: Int, column: Int){ // TRANSLATES A TAG NUMBER TO ASSOCIATED ROW
        let mytag = tag
        var row:Int
        var column:Int
        switch mytag {
        case 0,1,2,3: // ROW 0
            row = 0 //
            column = (mytag % 4)
            return (row, column)
        case 4,5,6,7: // ROW 1
            row = 1 //
            column = (mytag % 4)
            return (row, column)
        case 8,9,10,11: // ROW 2
            row = 2 //
            column = (mytag % 4)
            return (row, column)
        case 12,13,14,15: // ROW 3
            row = 3 //
            column = (mytag % 4)
            return (row, column)
        case 16,17,18,19: // ROW 4
            row = 4 //
            column = (mytag % 4)
            return (row, column)
        default:
            return (-1,-1)
        }
 
    }
 
    func checkWin()->Bool{ // CHECKS THE BOARD FOR A WIN
        if(matchesLeft<=0){
            return true
        }
        return false
    }
 
    func IsMatch(_ tag1:Int, _ tag2:Int)->Bool{ // CHECKS TO SEE IF THE TWO CARDS MATCH
 
        var emoji1:Node = getEmoji(tag1)
        var emoji2:Node = getEmoji(tag2)
 
        if (emoji1.emoji == emoji2.emoji) {
            emoji1.matched = true // Set values in struct to true
            emoji2.matched = true // Set values in struct to true
            return true
        }
        return false
    }
    func matchMade()
    {
        matchesLeft-=1

    }
 
}
