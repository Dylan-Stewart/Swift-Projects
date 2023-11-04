//
//  ViewController.swift
//  MyCalculator
//
//  Created by Dylan K. Stewart on 3/1/22.
//  Copyright © 2022 Dylan K. Stewart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let CB : CalcBrain = CalcBrain()
    var Response : String = ""
    
    @IBOutlet weak var lblOutput: UILabel!
    
    @IBAction func btnNumberClick(_ sender: UIButton) { //  Basically all the keys that directly result in a label change KEYS: 0 1 2 3 4 5 6 7 8 9 . = +/- % AC
        let mysendertag : Int = Int(sender.tag)
        Response = CB.btnNumberClick(tag: mysendertag)
//        guard let fck : String = lblOutput.text! else {
//            return
//        }
        lblOutput.text! = Response
    }
    
    @IBAction func btnArithematic(_ sender: UIButton) { // KEYS:  ÷   X   -   +
        let mysendertag : Int = Int(sender.tag)
        CB.btnArithematic(tag: mysendertag)
    }
    
//    @IBAction func btnArithematic2(_ sender: UIButton) { //  All the keys broken in my logic by doing this project KEYS: % +/- AC
//        let mysendertag : Int = Int(sender.tag)
//        Response = CB.btnArithematic2(tag: mysendertag)
//
//        lblOutput.text! = Response
//    }
    
    // STUFF IN SLIDES NOT SURE IF I NEED
//    @IBOutlet weak var txtInput: UILabel!
    //    @IBAction func btnOK_Click( sender: UIButton){
    //        guard let strInput = txtInput.text else{
    //            return
    //        }
    //        let response = CalcBrain(theAnswer: strInput)
    //
    //        txtInput.text = response.Response
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
