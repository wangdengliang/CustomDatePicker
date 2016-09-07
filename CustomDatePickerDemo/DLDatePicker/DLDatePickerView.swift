//
//  DLDatePickerView.swift
//  CustomDatePickerDemo
//
//  Created by cenon on 16/9/5.
//  Copyright © 2016年 jaway. All rights reserved.
//

import UIKit

protocol DLDatePickerViewDelegate : NSObjectProtocol {
    func cancleAction(sender:UIView)
    func confirmAction(sender :UIView,dateString:String)
}

class DLDatePickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate : DLDatePickerViewDelegate?
    
    var selectedDate : NSDate = NSDate()
   
    
    var dateFormatter  = NSDateFormatter()
    let normalTextColor : UIColor = UIColor.greenColor()
    let selectTextColor = UIColor.redColor()
    
    var yearArray = [Int]()
    var monthArray = [Int]()
    var dayArray = [Int]()
    let kTagForLabel: Int = 100
    
    
    
    
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds))
        
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        //dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        //dateFormatter.timeZone  = NSTimeZone.localTimeZone()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.initData()
        pickerView.reloadAllComponents()
        
        

    }
    
    
    
    func initData()  {
        
        
        let string = dateFormatter.stringFromDate(selectedDate);
        
        let array = string.componentsSeparatedByCharactersInSet(NSCharacterSet.init(charactersInString: "年月日 /"))
        
        let y  = Int(array[0])!
        
        
        for i in 0..<30 {
            
            yearArray.insert(y+i, atIndex: i)
            
        }
        
        for i in 1...12 {
            monthArray.insert(i, atIndex: i-1)
        }
        
        for i in 1...31 {
            dayArray.insert(i, atIndex: i-1)
        }
        
        
    }
    
    
    @IBAction func confirmAction(sender: UIButton)
    {
    
        delegate?.cancleAction(self)
        
        
        let sy = pickerView.selectedRowInComponent(0)
        let sm = pickerView.selectedRowInComponent(1)
        let sd = pickerView.selectedRowInComponent(2)
        
        
        if let d = dateFormatter.dateFromString("\(yearArray[sy])年\(monthArray[sm])月\(dayArray[sd])日")
        {
            selectedDate = d
        }
        let datestring : String = dateFormatter.stringFromDate(selectedDate)
        delegate?.confirmAction(self, dateString: datestring)
        
        
    }
    
    
    
    @IBAction func cancleAction(sender: UIButton) {
    
        delegate?.cancleAction(self)
        
    }
    
    func getlastDayin(year:Int,month:Int) -> Int {
        
        switch month {
        case 1,3,5,7,8,10,12:
            return 31
        case 2:
            if year%4 == 0 {
                
                if year%100 == 0 {
                    if year%400 == 0 {
                        return 29
                    }
                    
                }
                else
                {
                return 29
                }
            }
            return 28
        default:
            return 30
        }
        
    }
    
    func numberOfDayInComponent() -> Int {
        
        let sy = pickerView.selectedRowInComponent(0)
        let sm = pickerView.selectedRowInComponent(1)
        
        return self.getlastDayin(yearArray[sy], month: monthArray[sm])
        
    }
    
    // MARK: picker view
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
//    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        switch component {
//        case 0:
//            return 150
//        
//            
//        default:
//            return 50
//        }
//    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return yearArray.count
            
        case 1:
            return monthArray.count
        case 2:
            
            return self.numberOfDayInComponent()
            
        default:
            return 0
        }
}
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        
        
        
        if let v = view {
           
            
            let label : UILabel = v as! UILabel
            
            label.textColor = normalTextColor
            switch component {
            case 0:
                label.frame.size.width = 150
                label.text = "\(yearArray[row])年"
            case 1:
                label.text = "\(monthArray[row])月"
                
            case 2:
                label.text = "\(dayArray[row])日"
                
            default:
                break
            }

            return label;
        }
        else
        {
            let label : UILabel = UILabel.init(frame: CGRectMake(0, 0, 44, 50))
            
            
            
            label.textColor = normalTextColor
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(14)
            label.tag = kTagForLabel
            
            switch component {
            case 0:
                
                label.frame.size.width = 150
                
                label.text = "\(yearArray[row])年"
            case 1:
                label.text = "\(monthArray[row])月"
                
            case 2:
                label.text = "\(dayArray[row])日"
                
            default:
                break
            }

           return label;
            
        }
        
        
        
        
        

        
        
}
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let label = pickerView.viewForRow(row, forComponent: component) as! UILabel
        
        label.textColor = selectTextColor
        
        switch component {
        case 0,1:
            pickerView.reloadComponent(2)
            
        default:
            break
        }
   
        
}


}


