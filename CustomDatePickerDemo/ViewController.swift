//
//  ViewController.swift
//  CustomDatePickerDemo
//
//  Created by cenon on 16/9/5.
//  Copyright © 2016年 jaway. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DLDatePickerViewDelegate {

    @IBOutlet var datePickerView: DLDatePickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePickerView.delegate = self
    }

    
    func confirmAction(sender: UIView, dateString: String) {
        
        print(dateString)
    }
    
    func cancleAction(sender: UIView) {
        datePickerView.frame.origin.y = 0
        UIView.animateWithDuration(0.5, animations: {
            self.datePickerView.frame.origin.y = CGRectGetHeight(UIScreen.mainScreen().bounds)
        }) { (complete) in
            self.datePickerView.removeFromSuperview()
            print(complete)
        }
        
    }
    @IBAction func datepickerShow(sender: UIButton) {
        
        datePickerView.frame.origin.y = CGRectGetHeight(UIScreen.mainScreen().bounds)
        self.view.addSubview(datePickerView)
        
        UIView.animateWithDuration(0.5, animations: { 
            self.datePickerView.frame.origin.y = 0
            }) { (complete) in
                print(complete)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

