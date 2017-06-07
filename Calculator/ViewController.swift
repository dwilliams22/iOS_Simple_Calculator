//
//  ViewController.swift
//  Calculator
//
//  Created by Deonte Williams on 6/6/17.
//  Copyright © 2017 Deonte Williams. All rights reserved.
//

import UIKit

enum modes {
    case notSet
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    
    var labelString: String = "0"
    var currentMode: modes = .notSet
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeMode(newMode: .multiplication)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt = Int(labelString) else {
            return
        }
        
        if currentMode == .notSet || lastButtonWasMode{
            return
        }
        
        if currentMode == .addition {
            savedNum += labelInt
        }
        else if currentMode == .subtraction {
            savedNum -= labelInt
        }
        else if currentMode == .multiplication {
            savedNum *= labelInt
        }
        currentMode = .notSet
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .notSet
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue: String? = sender.titleLabel?.text
        
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    func updateText() {
        guard let labelInt = Int(labelString) else {
            return
        }
        if currentMode == .notSet {
            savedNum = labelInt
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: labelInt)
        label.text = formatter.string(from: num)
    }
    
    func changeMode(newMode: modes) {
        
        if savedNum == 0 {
            return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
        
    }

}

