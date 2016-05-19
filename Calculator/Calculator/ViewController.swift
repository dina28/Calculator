//
//  ViewController.swift
//  Calculator
//
//  Created by Kazi Sharmin Dina on 5/18/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var expressionTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    let kLimit: Float = -100000000.0
    var result: Float = -100000000.0
    var currentNumber: Float = -100000000.0
    var currentOperator: String!
    var flag = false
    var tag = false
    let kNotNumber = "Not Number"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentOperator = "="
        resultTextField.text = "0"
        resultTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: @IBAction Methods
    
    @IBAction func btnNumberInputAction(sender: UIButton) {
        if ((currentOperator == "=" && !tag) || (currentNumber <= 0)) {
            currentNumber = Float((Int)(sender.titleLabel!.text!)!)
            tag = true
        } else {
            currentNumber = currentNumber * 10 + Float((Int)(sender.titleLabel!.text!)!)
        }
        showResult(currentNumber)
        showExpression()
    }
    
    @IBAction func btnNumberClearAction(sender: AnyObject) {
        if currentNumber <= 0 && result > kLimit {
            currentNumber = result
            result = kLimit
        }
        if currentNumber > 0 {
            var number: Int = Int(currentNumber)
            number = number / 10
            currentNumber = Float(number)
            showResult(currentNumber)
            showExpression()
        }
        if currentNumber <= 0 {
            tag = false
        }
    }
    
    @IBAction func btnOperation(sender: UIButton) {
        tag = false
        switch currentOperator {
        case "=":
            result = currentNumber
        case "+":
            if (result != kLimit && currentNumber != kLimit) {
                result = result + currentNumber
            }
        case "-":
            if (result != kLimit && currentNumber != kLimit) {
                result = result - currentNumber
            }
        case "*":
            if (result != kLimit && currentNumber != kLimit) {
                result = result * currentNumber
            }
        case "/":
            if (result != kLimit && currentNumber != kLimit) {
                if (currentNumber == 0) {
                    flag = true;
                } else if (result > 0 && currentNumber > 0) {
                    result = result / currentNumber
                }
            }
        default:
            print("error")
        }
        if (result == kLimit && currentNumber !=  kLimit ) {
            result = currentNumber
        }
        currentNumber = kLimit
        if (flag) {
            resultTextField.text = kNotNumber
            flag = false
        } else {
            showResult(result)
            showExpression()
        }
        if (sender.titleLabel!.text == "=") {
            currentNumber = result
            result = kLimit
        }
        currentOperator = sender.titleLabel!.text! as String
    }
    
    @IBAction func btnClearAction(sender: UIButton) {
        currentOperator = "="
        currentNumber = kLimit
        result = kLimit
        resultTextField.text = "0"
        expressionTextField.text = ""
    }
    
    //MARK: Custom Methods
    
    func showResult(resultText: Float) {
        if resultText != kLimit {
            if (numberFormat(resultText)) {
                resultTextField.text = String(resultText)
            } else {
                resultTextField.text = String(Int(resultText))
            }
        }
    }
    
    func numberFormat(number: Float) -> Bool {
        let numberInt = Int(number)
        if Float(numberInt) == number {
            return false
        }
        return true
    }
    
    func showExpression() {
        if (result == kLimit && currentNumber > 0 ) {
            if numberFormat(currentNumber) {
                expressionTextField.text = String(currentNumber)
            } else {
                expressionTextField.text = String(Int(currentNumber))
            }
        } else if (result > kLimit && currentNumber == kLimit) {
            if numberFormat(result) {
                expressionTextField.text = String(result)
            } else {
                expressionTextField.text = String(Int(result))
            }
        } else if (result != kLimit && currentNumber != kLimit ) {
            var tempString = ""
            if numberFormat(result) {
                tempString = String(result)
            } else {
                tempString = String(Int(result))
            }
            tempString = tempString + " " + currentOperator + " "
            if numberFormat(currentNumber) {
                tempString = tempString + String(currentNumber)
            } else {
                tempString = tempString + String(Int(currentNumber))
            }
            expressionTextField.text = tempString
        } else {
            expressionTextField.text = ""
        }
    }
    
    //MARK: Delegate Method
    
    func textFieldShouldBeginEditing(state: UITextField) -> Bool {
        return false
    }
    
}