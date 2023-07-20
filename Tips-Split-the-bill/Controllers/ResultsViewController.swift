//
//  ResultsViewController.swift
//  Tips-Split-the-bill
//
//  Created by Puscas Paul on 17.07.2023.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalPerPerson = "0.0"
    var splitBetweenHowManny = 2
    var tipSelected = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = totalPerPerson
        settingsLabel.text = "Split between \(splitBetweenHowManny) people, with \(tipSelected)% tip."
    }
    
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
