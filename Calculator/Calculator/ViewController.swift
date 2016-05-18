//
//  ViewController.swift
//  Calculator
//
//  Created by Kazi Sharmin Dina on 5/18/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultTextField: UITextField!
    var result = Float();
    var currentNumber = Float();
    var currentOperator: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentOperator = "="
        resultTextField.text = String(result)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnNumberInputAction(sender: UIButton) {
        currentNumber = currentNumber * 10 + Float((Int)(sender.titleLabel!.text!)!)
        resultTextField.text = String(currentNumber)
    }
    
    @IBAction func btnOperation(sender: UIButton) {
        switch currentOperator {
        case "=":
            result = currentNumber
        case "+":
            result = result + currentNumber
        case "-":
            result = result - currentNumber
        case "*":
            result = result * currentNumber
        case "/":
            result = result / currentNumber
        default:
            print("error")
        }
        currentNumber = 0
        resultTextField.text = String(result)
        if (sender.titleLabel!.text == "=") {
            result = 0
        }
        currentOperator = sender.titleLabel!.text! as String
    }
    
    @IBAction func btnClearAction(sender: UIButton) {
        currentOperator = "="
        currentNumber = 0
        result = 0
        resultTextField.text = String(result)
    }
}

