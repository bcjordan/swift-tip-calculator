//
//  ViewController.swift
//  tips
//
//  Created by Brian Jordan on 1/9/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func syncToSavedAmounts() {
        var savedTipAmounts = getSavedTipArray()
        var index:Int
        for index = 0; index < savedTipAmounts.count; ++index {
            var tipPercentageString = String(format: "%.0f%%", savedTipAmounts[index] as Double * 100)
            tipControl.setTitle(tipPercentageString, forSegmentAtIndex: index)
        }
    }
    
    private func getSavedTipArray() -> Array<Double> {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tip1 = defaults.doubleForKey("tipPercentage1")
        var tip2 = defaults.doubleForKey("tipPercentage2")
        var tip3 = defaults.doubleForKey("tipPercentage3")
        return [tip1, tip2, tip3]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        syncToSavedAmounts()
        recalculateTotal()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        syncToSavedAmounts();
        recalculateTotal()
    }
    
    private func recalculateTotal() {
        var tipPercentage = getSavedTipArray()[tipControl.selectedSegmentIndex]
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

