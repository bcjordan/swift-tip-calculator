//
//  SettingsViewController.swift
//  tips
//
//  Created by Brian Jordan on 1/9/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var option1Field: UITextField!
    @IBOutlet weak var option2Field: UITextField!
    @IBOutlet weak var option3Field: UITextField!

    @IBOutlet weak var tipAmountControlPreview: UISegmentedControl!
    
    @IBAction func optionChanged(sender: AnyObject) {
        saveConfiguredAmounts()
        syncToSavedAmounts()
    }
    
    private func saveConfiguredAmounts() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var optionFieldsToKeys = [
            "tipPercentage1": option1Field,
            "tipPercentage2": option2Field,
            "tipPercentage3": option3Field
        ]
        
        for (key, field) in optionFieldsToKeys {
            defaults.setDouble(field.text._bridgeToObjectiveC().doubleValue, forKey: key)
        }
        
        defaults.synchronize()
    }
    
    private func syncToSavedAmounts() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var savedTipAmounts = getSavedTipArray()
        var optionFields = [option1Field, option2Field, option3Field]
        
        var index:Int
        for index = 0; index < savedTipAmounts.count; ++index {
            var tipPercentageString = String(format: "%.0f%%", savedTipAmounts[index] as Double * 100)
            tipAmountControlPreview.setTitle(tipPercentageString, forSegmentAtIndex: index)
            optionFields[index].text = String(format: "%.2f", savedTipAmounts[index])
        }
    }
    
    private func getSavedTipArray() -> Array<Double> {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tip1 = defaults.doubleForKey("tipPercentage1")
        var tip2 = defaults.doubleForKey("tipPercentage2")
        var tip3 = defaults.doubleForKey("tipPercentage3")
        return [tip1, tip2, tip3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncToSavedAmounts()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
