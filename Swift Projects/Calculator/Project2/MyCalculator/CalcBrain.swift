//
//  CalcBrain.swift
//  MyCalculator
//
//  Created by Dylan K. Stewart on 3/31/22.
//  Copyright © 2022 Dylan K. Stewart. All rights reserved.
//

import Foundation

class CalcBrain { // subclass of view controller
    
    var Label : String
    var displayValue: String
    var tag : Int
    
    init(){
        Label = "0"
        tag = -1
        displayValue = Label
    }

    

    
var result:Double = 0
var numberino:Double = 0
var previous:Double = 0
var executing:Bool = false
var justpressed:Bool = false
var decimalflag:Bool = false
var currentsign:String = " "
var decimalfirst:Bool = false
var doneacalc:Bool = false
    
    func btnNumberClick(tag : Int) -> ( _ : String) {
    //        guard let sometext = sender.titleLabel?.text else {
    //            return
    //        }
        if tag == 12{ // change sign
            
            if Label == "0"{
                Label = "-0"
                displayValue = Label
                return Label
            }
            if Label == "0"{
                Label = "-0"
                displayValue = Label
                return Label
            }
            Label = String(-1*Double(Label)!)
            currentsign = " "
            displayValue = Label
            return Label
        }
        
        if tag == 13{ // percentage
            currentsign = "%"
            result = Double(Label)!/100
            Label = String(result)
            displayValue = Label
            return Label
        }
        
        if tag == 11{ // CLEAR BUTTON
            Label = "0"
            numberino = 0
            previous = 0
            currentsign = " "
            justpressed = false
            executing = false
            decimalflag = false
            decimalfirst = false
            doneacalc = false
            displayValue = Label
            return Label
        }
        
    
    if executing == true{
        
        if currentsign != " " && justpressed == true { // THEN I NEED TO CLEAR TEXT BOX FOR NEXT INPUT
            // WE ADD NEXT INPUT TERM
            Label = String(tag-1)
            if (tag == 30) { // CASE THEY PRESS DECIMAL KEY INSTEAD OF 0 FIRST
                Label = "0."
                decimalfirst = true
            }
            justpressed = false
            numberino = Double(Label)!
            displayValue = Label
            return Label
        }
        
        
        if tag == 18 { // EQUALS PRESSED
            executing = false // I RESET EXECUTION
            doneacalc = true
            if decimalfirst == true{ // CASE THEY PRESS DECIMAL INSTEAD OF 0 FIRST
                numberino = Double(Label)!
                decimalflag = true // I also recognize its a decimal
            }
            switch(currentsign){
            case "+":
                result = previous + numberino
                if (decimalflag == false){ // CASE WE ARE DEALING WITH NO DECIMALS
                    Label = String(Int(result))
                    displayValue = Label
                    currentsign = " "
                    break
                }
                Label = String(result)
                displayValue = Label
                currentsign = " "
                break
            case "-":
                result = previous - numberino
                if (decimalflag == false){ // CASE WE ARE DEALING WITH NO DECIMALS
                    Label = String(Int(result))
                    displayValue = Label
                    currentsign = " "
                    break
                }
                Label = String(result)
                displayValue = Label
                currentsign = " "
                break
            case "X":
                result = previous * numberino
                if (decimalflag == false){ // CASE WE ARE DEALING WITH NO DECIMALS
                    Label = String(Int(result))
                    displayValue = Label
                    currentsign = " "
                    break
                }
                Label = String(result)
                displayValue = Label
                currentsign = " "
                break
            case "/":
                result = previous / numberino
                let temp:String = String(result)
                //                    var evencheck1 = previous.truncatingRemainder(dividingBy: 2)
                //                    var evencheck2 = numberino.truncatingRemainder(dividingBy: 2)
                if (decimalflag == false && !(temp.contains("."))) { // CASE WE ARE DEALING WITH NO DECIMALS AND RESULT IS NOT A DECIMAL
                    Label = String(Int(result))
                    displayValue = Label
                    currentsign = " "
                    break
                }
                Label = String(result)
                displayValue = Label
                currentsign = " "
                break
            default:
                break // do nothing
            }
        }
    }
    if Label == "0"  && tag != 30 && tag != 18 {  // CHECKS IF INITIAL VALUE IS 0 and changes to pressed key
        Label = String(tag-1)
        displayValue = Label
        return Label
    }
    
    if Label == "-0" && tag != 30 && tag != 18{
        Label = String(tag-1)
        Label = "-" + Label // KEEPS NEGATIVE SIGN WHEN SETTING 0 NEGATIVE TO WHATEVER NEGATIVE
        displayValue = Label
        return Label
    }
    
    if tag == 30 {// WE ARE DOING DOUBLE CALCULATIONS DECIMAL FLAG = TRUE
        if !(Label.contains(".")){ // CASE USER TRIES TO INPUT TWO DECIMALS AT ONCE
            Label += "."
        }
        decimalflag = true
        displayValue = Label
        return Label
        
    }
        if tag != 30 && tag != 18 && doneacalc == true { // NEW I added this because I was disappointed in myself for not having it reset after doing a calculation and pressing a new number. I thought I had this implemented already in Project 1 so I thought I would add this flag...
            Label = String(tag-1)
            previous = Double(Label)!
            doneacalc = false
            displayValue = Label
            return Label
        }
        
    if tag != 30 && tag != 18{ // makes sure it doesn't add 17 or 29 to my result
        Label = Label + String(tag-1) // Concatenates numbers to the string
        numberino = Double(Label)!
        displayValue = Label
        return Label
    }
        displayValue = Label
        return Label
}




    func btnArithematic(tag: Int) {
    
    // MY SIGNS AND AIRITHEMATIC BUTTONS  //
    //if tag != 18 { // WRAPPER FOR MY SWITCH no purpose will always run
        
        previous = Double(Label)!
        switch(tag){
        case 14: // divide
            currentsign = "/"
            justpressed = true
            break
        case 15: // multiply
            currentsign = "X"
            justpressed = true
            break
        case 16: // subtract
            currentsign = "-"
            justpressed = true
            break
        case 17:  // add
            currentsign = "+"
            justpressed = true
            break
            
        default: // do nothing
            break
        }
        executing = true
    
    return
}
    
    //func btnArithematic2(tag: Int) -> (_: String) {
        // was going to put the buttons that got broken in this but i decided to just put it in the other buttonclick func
       // return Label
    //}
    
}

