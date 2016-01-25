//
//  ViewController.swift
//  RetroCalulator
//
//  Created by Josh Christensen on 1/24/16.
//  Copyright © 2016 OrangeDev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation:String {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case equals = "="
        case empty = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    
    //Outlets
    @IBOutlet weak var OutputLbl: UILabel!
    
    //Vars
    var btnSound: AVAudioPlayer!
    var OpSelected: Operation = Operation.empty
    
    var Output:Double = 0.0
    var typedNumbers:String = ""
    var lastTypedNum:String = ""
    
    //Actions
    @IBAction func btnPressed(btn: UIButton!) {
        btnSound.play()
        
        if btn.tag < 10 {
            typedNumbers += "\(btn.tag)"
            OutputLbl.text = typedNumbers
        }
        
    }
    
    @IBAction func Add(sender: AnyObject) {
        processOperation(.add)
    }
    
    @IBAction func Subtract(sender: AnyObject) {
        processOperation(.subtract)
    }
    
    @IBAction func Multiply(sender: AnyObject) {
        processOperation(.multiply)
    }
    
    @IBAction func Divide(sender: AnyObject) {
        processOperation(.divide)
    }
    
    @IBAction func Equals(sender: AnyObject) {
        processOperation(.equals)
    }
    
    
    //Functions
    
    func processOperation(op: Operation) {
        if OpSelected != Operation.empty {
            if typedNumbers != "" {
                switch OpSelected {
                case Operation.add:
                    OutputLbl.text = "\(Double(lastTypedNum)! + Double(typedNumbers)!)"
                case Operation.subtract:
                    OutputLbl.text = "\(Double(lastTypedNum)! - Double(typedNumbers)!)"
                case Operation.multiply:
                    OutputLbl.text = "\(Double(lastTypedNum)! * Double(typedNumbers)!)"
                case Operation.divide:
                    OutputLbl.text = "\(Double(lastTypedNum)! / Double(typedNumbers)!)"
                default:
                    break
                }
            
                typedNumbers = ""
                lastTypedNum = OutputLbl.text!
                OpSelected = op
            }
            
        } else {
            OpSelected = op
            lastTypedNum = typedNumbers
            typedNumbers = ""
        }
        
        
    }


}

