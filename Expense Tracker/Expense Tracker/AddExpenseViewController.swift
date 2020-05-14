//
//  AddExpenseViewController.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController, CatagorySelectDelegate {
    
    
    
    @IBOutlet weak var txtExpenseTitle: UITextField!
    @IBOutlet weak var txtExpenseAmount: UITextField!
    @IBOutlet weak var txtExpenseNote: UITextView!
    @IBOutlet weak var txtExpenseDate: UITextField!
    @IBOutlet weak var txtExpenseCatagory: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.txtExpenseDate.setInputViewDatePicker(target: self, selector: #selector(tapDateSelect))
        self.txtExpenseNote.addBorder(withColor: themeColor)
    }
    
    func catagoryWasSelected(sender: [Catagories]) {
        if !self.txtExpenseCatagory.text!.isEmpty{
            self.txtExpenseCatagory.text = ""
        }
        for catagory in sender {
            if catagory.selected{
                self.txtExpenseCatagory.text! += "\((catagory).catagoryname),"
                
            }
        }
    }
    
    @IBAction func btnSaveClicked(sender: UIButton){
        if self.isValidInput(title: txtExpenseTitle.text!, amount: txtExpenseAmount.text!, date: txtExpenseDate.text!, catagory: txtExpenseCatagory.text!){
            
            let result = DBManager.getInstance().insertDataToExpense(model: Expense(title: txtExpenseTitle.text!, amount: Double(txtExpenseAmount.text!), note: txtExpenseNote.text, date: txtExpenseDate.text!, catagory: txtExpenseCatagory.text!))
            if result{
                Utility.AlertMessage(title: alertTitleAddExpense, message: EXPENSEADDEDSUCCESSFULLY, alertActionTitile: alertActionTitle, viewController: self)
                Utility.ResetSelectedCatagories()
                
            }
            
        }
    }
    
    @IBAction func btnBackClicked(sener: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCatagorySelectClicked(sender: UIButton){
        Utility.pushViewController(identifier: catagoryListViewController, viewcontroller: self)
    }
    
    @objc func tapDateSelect(){
        if let datePicker = self.txtExpenseDate.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = dateFormatToConvert
            self.txtExpenseDate.text = dateformatter.string(from: datePicker.date)
        }
        self.txtExpenseDate.resignFirstResponder()
        
    }
    
    func isValidInput(title: String, amount: String, date: String, catagory: String) -> Bool{
        if title.isEmpty{
            Utility.alertMessage(title: alertActionTitle, message: PLEASEENTERVALIDTITLE, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        else if amount.isEmpty {
            Utility.alertMessage(title: alertActionTitle, message: PLEASEENTERVALIDAMOUNT, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        else if Double(amount) == 0{
            Utility.alertMessage(title: alertActionTitle, message: PLEASEENTERVALIDAMOUNT, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        else if date.isEmpty{
            Utility.alertMessage(title: alertActionTitle, message: PLEASEENTERVALIDDATE, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        else if catagory.isEmpty{
            Utility.alertMessage(title: alertActionTitle, message: PLEASEENTERVALIDCATAGORY, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        return true
    }
}

import UIKit
extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = mainScreen.width
        let screenheight = mainScreen.height
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenheight * 0.20))
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        self.inputView = datePicker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(btnCancelClicked))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flex, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func btnCancelClicked() {
        self.resignFirstResponder()
    }
    
}

extension UITextView{
    
    func addBorder(withColor: UIColor){
        self.layer.borderColor = withColor.cgColor
        self.layer.borderWidth = 2.0
    }
}
