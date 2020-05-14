//
//  Utility.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import Foundation
import  UIKit
class Utility: NSObject{
    
    class func getFilePath(fileName: String) -> String{
        
        let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        let fileURL = documentDir.appendingPathComponent(fileName)
        print("File Path = \(fileURL.path)")
        
        return fileURL.path
    }
    
    class func makeDataBase(fileName: String){
        
        let databasePath = getFilePath(fileName: dataBaseName)
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: databasePath)
        {
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(fileName)
            do
            {
                try fileManager.copyItem(atPath: (file?.path)!, toPath: databasePath)
            }catch let error as NSError{
                if(error ==  nil)
                {
                    print(error.localizedDescription)
                }else{
                    print("Successful")
                }
                
            }
            
        }
    }
    
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = emailREGex
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    class func alertMessage(title: String, message: String, alertActionTitile: String, viewController: UIViewController?) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: alertActionTitile, style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        viewController!.present(alert, animated: true, completion: nil)
    }
    
    class func AlertMessage(title: String, message: String, alertActionTitile: String, viewController: UIViewController) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: alertActionTitile, style: .default) { (action) in
            viewController.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func setValueInDefaults(value: Any, key: String){
        userDefaults.set(value, forKey: key)
    }
    
    
    class func pushViewController(identifier: String, viewcontroller: UIViewController){
        let storyBoard = UIStoryboard.init(name: mainStoryBoard, bundle: nil)
        var destinationVC = UIViewController()
        switch identifier {
        case expenseListViewController:
            destinationVC = storyBoard.instantiateViewController(identifier: identifier) as! ExpenseListViewController
        case catagoryListViewController:
            destinationVC = storyBoard.instantiateViewController(identifier: identifier) as! CatagoryListViewController
            (destinationVC as! CatagoryListViewController).catagorySelectDelegate = viewcontroller.self as? CatagorySelectDelegate
        case addExpenseViewController:
            destinationVC = storyBoard.instantiateViewController(identifier: identifier) as! AddExpenseViewController
        case graphViewController:
            destinationVC = storyBoard.instantiateViewController(identifier: graphViewController) as! GraphViewController
        default: break
        }
        viewcontroller.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    class func ResetSelectedCatagories(){
        for index in 0..<appdelegate.arrCatagories.count {
            appdelegate.arrCatagories[index].selected = false
        }
    }
    
    // String to date
    class func dateFromString(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatToConvert
        
        return dateFormatter.date(from: dateStr)!
        
    }
    
    class func stringFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatToConvert
        return dateFormatter.string(from: date)
    }
    
    class func getDistinctDays(minimumdate: Date, maximumDate: Date) -> Int{
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: minimumdate)
        let date2 = calendar.startOfDay(for: maximumDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
    
    class func getDistinctMonth(minimumdate: Date, maximumDate: Date) -> Int{
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: minimumdate)
        let date2 = calendar.startOfDay(for: maximumDate)

        let components = calendar.dateComponents([.month], from: date1, to: date2)
        return components.month!
    }
    
}

extension Date{
    
     func Greaterthan (lhs: Date, rhs: Date) -> Date{
        if lhs.compare(rhs) == .orderedDescending{
            return lhs
        }
        else{
            return rhs
        }
        
    }
    
    func Lessthan (lhs: Date, rhs: Date) -> Date{
        if lhs < rhs{
            return lhs
        }
        else{
            return rhs
        }
    }
}
