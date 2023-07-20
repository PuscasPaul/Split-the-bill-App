//
//  ViewController.swift
//  Tips-Split-the-bill
//
//  Created by Puscas Paul on 17.07.2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var resultTo2DecimalPlaces = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billTextField.delegate = self
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
       // Deselects all the tip buttons via IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        // Makes the button that triggered the IBAction selected.
        sender.isSelected = true
        // ends editing so keyboard hides in case user wants to press Calculate
        billTextField.endEditing(true)

        // Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        // Remove the last character (%) from title then turn it back to a String
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        
        // Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!

        // Divide the percent expressed out of 100 into a decimal e.g. 10 becmoes 0.1
        tip = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Get the stepper value using sender.value round it down to a whole num
        // then set it as the text in splitNumberLabel
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        // Set the numberOfPeople property as the value of the stepper as a whole number
        numberOfPeople = Int(sender.value)
        // ends editing so keyboard hides in case user wants to press Calculate
        billTextField.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // change the , to . on real phone in order to not throw error
        let bill = billTextField.text!.replacingOccurrences(of: ",", with: ".")
        // prevent app from crashing if first item is .
        if bill.first == "." || bill.count == 0 {
            return
        }
        
        // if text is not an empty string
        if bill != "" {
            //Turn the bill from a String e.g. "156.30" to an actual String with decimal places.
            //e.g. 156.30
            billTotal = Double(bill)!
        }
        // Multiply the bill by the tip percentage and divide the num of people to split bill.
        let result = billTotal * (1 + tip) / Double(numberOfPeople)
        
        // Round the result to 2 decimal places and turn into a String.
        resultTo2DecimalPlaces = String(format: "%.2f", result)
        
        // go to second screen
        performSegue(withIdentifier: "Present Modally", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "Present Modally" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = resultTo2DecimalPlaces
            destinationVC.splitBetweenHowManny = numberOfPeople
            destinationVC.tipSelected = Int(tip * 100)
        }
    }
}

// MARK: - UITextField Delegate

extension CalculatorViewController: UITextFieldDelegate {
    // prevents app from crashing by adding multiple dots .
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "." {
            let countDots = billTextField.text!.components(separatedBy: ".").count - 1
            if countDots == 0 {
                return true
            } else {
                if countDots > 0 && string == "." {
                    return false
                } else {
                    return true
                }
            }
        }
        return true
    }
}

