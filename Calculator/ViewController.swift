//
//  ViewController.swift
//  Calculator
//
//  Created by Pranav Achanta on 9/29/15.
//  Copyright (c) 2015 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Instance Variables --> also called Propeties
    // and Methods -->
    
    var userIsInTheMiddleOfTyping = false
    
    var saveViewCreated = false
    
    var currentActiveMemory = 0
    
    var memoryInDisplay = false
    
    var buttons = [UIButton]()
    
    var lastDigitisNUmber = false
    
    var operandGroup = 0
    
    var stack = [String]()
    
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var divideButton: UIButton!
    
    @IBOutlet weak var multiplyButton: UIButton!
    
    @IBOutlet weak var additionButton: UIButton!
    
    @IBOutlet weak var subtractButton: UIButton!
    
    @IBOutlet weak var equalsButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var reverseSignButton: UIButton!
    
    @IBOutlet weak var percentButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var m1height: NSLayoutConstraint!
    
    @IBOutlet weak var m2height: NSLayoutConstraint!
    
    @IBOutlet weak var m3height: NSLayoutConstraint!
    
    @IBOutlet weak var m1button: UIButton!
    
    @IBOutlet weak var m2button: UIButton!
    
    @IBOutlet weak var m3button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [m1button, m2button, m3button]
        
        m1button.setTitle("", forState: UIControlState.Normal)
        m2button.setTitle("", forState: UIControlState.Normal)
        m3button.setTitle("", forState: UIControlState.Normal)
        
        divideButton.backgroundColor = UIColor.redColor()

        multiplyButton.backgroundColor = UIColor.redColor()
        
        additionButton.backgroundColor = UIColor.redColor()
        
        subtractButton.backgroundColor = UIColor.redColor()
        
        equalsButton.backgroundColor = UIColor.redColor()
        
        clearButton.backgroundColor = UIColor.redColor()

        reverseSignButton.backgroundColor = UIColor.redColor()
        
        percentButton.backgroundColor = UIColor.redColor()
        
        hideMemoryDisplay()
    }
    
    @IBAction func populateM1(sender: UIButton) {
        let value = sender.titleLabel?.text!
        display.text = value
        stack.append(value!)
        lastDigitisNUmber = true
    }
    
    func hideMemoryDisplay(){
        m1height.constant = 0
        m2height.constant = 0
        m3height.constant = 0

    }
    
    func showMemoryDisplay(){
        m1height.constant = 40
        m2height.constant = 40
        m3height.constant = 40
    }
    
    @IBAction func onClear(sender: AnyObject) {
        // Clear the Value
        display.text = ""
        stack.removeAll()
    }
    
    @IBAction func onSave(sender: AnyObject) {
        if(currentActiveMemory < 3){
            if(!memoryInDisplay){
                showMemoryDisplay()
            }
            
            let button = buttons[currentActiveMemory]
            let value = display.text!
            button.setTitle(value, forState: UIControlState.Normal)
            currentActiveMemory++
        }
    }
    
    @IBAction func equals(sender: AnyObject) {
        if userIsInTheMiddleOfTyping {
            enter()
        }
        
        if(!lastDigitisNUmber){
            if(operandGroup == 1){
                stack.append("1")
            }else if(operandGroup == 0){
                stack.append("0")
            }
        }
        var expression = ""
        
        // Build the Expression
        for s in stack{
            expression += s
        }
        
        let exp = NSExpression(format: expression)
        let result = String( exp.expressionValueWithObject(nil, context: nil) as! NSNumber)
        stack.removeAll()
        stack.append(result)
        display.text = result
    }
    
    @IBAction func onPercentage(sender: AnyObject) {
        let value = NSNumberFormatter().numberFromString(display.text!)!.doubleValue/100
        let stringValue = String(value)
        display.text = stringValue
        stack.removeLast()
        stack.append(stringValue)
    }
    
    @IBAction func reverseSign(sender: AnyObject) {
        var value = NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        
        if value > 0{
            value *= -1
        }else{
            value *= 1
        }
        
        let stringValue = String(value)
        display.text = stringValue
        stack.removeLast()
        stack.append(stringValue)
    }
    
    
    @IBAction func appenDigit(sender: UIButton) {
        // This is a common method for all digits
        // Extract the digit from the sender argument
        let digit = sender.currentTitle!
        
        // Append the digits to the
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        lastDigitisNUmber = true
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        // if the User is Typing, enter the current value and perform the operation
        if userIsInTheMiddleOfTyping {
            enter()
        }
        
        stack.append(returnOperator(operation))
        lastDigitisNUmber = false
    }
    
    func returnOperator(operation : String) -> String{
            switch operation{
                case "x" :
                    operandGroup = 1
                    return "*"
                case "/" :
                    operandGroup = 1
                    return "/"
                case "+":
                    operandGroup = 0
                    return "+"
                case "-" :
                    operandGroup = 0
                    return "-"
                default:return ""
            }
    }
    
    func enter() {
        userIsInTheMiddleOfTyping = false
        stack.append(String(displayValue))
//        expression += String(displayValue) + " "
    }
    
    var displayValue : Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
}

