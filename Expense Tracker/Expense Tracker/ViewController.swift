//
//  ViewController.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-11.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPasscode: UITextField!
    @IBOutlet weak var txtConfirmPasscode: UITextField!
    
    @IBOutlet weak var lblConfirmPasscode: UILabel!
    @IBOutlet weak var contentviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        validateUI(flag: userDefaults.value(forKey: ISFIRSTTIME) as! Bool)
    }

    
    func isValid(passCode: String, confirmPasscode: String) -> Bool{
        
        if passCode != confirmPasscode
        {
            Utility.AlertMessage(title: alertTitleRegister, message: PASSCODEDEOSNOTMATCH, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
    
        if passCode.count > 4
        {
            Utility.AlertMessage(title: alertTitleRegister, message: PASSCODELENGTH, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        
        return true
    }
    
    func validateLogin(passcode: String) -> Bool{
        
        if(userDefaults.value(forKey: PASSCODE) as! String != passcode)
        {
            Utility.AlertMessage(title: alertTitleLogin, message: LOGINERROR, alertActionTitile: alertActionTitle, viewController: self)
            return false
        }
        
        return true
    }
    
    @IBAction func btnRegisterClicked(sender: UIButton)
    {
        if(userDefaults.value(forKey: ISFIRSTTIME) as! Bool){
            if isValid(passCode: txtPasscode.text!, confirmPasscode: txtConfirmPasscode.text!)
            {
                appdelegate.isFirstTime = false
                appdelegate.passcode = txtPasscode.text!
                Utility.setValueInDefaults(value: appdelegate.isFirstTime, key: ISFIRSTTIME)
                Utility.setValueInDefaults(value: appdelegate.passcode, key: PASSCODE)
                DBManager.getInstance().featchDataFromTheTable()
                Utility.pushViewController(identifier: expenseListViewController, viewcontroller: self)
            }
        }
        else{
            let login = validateLogin(passcode: txtPasscode.text!)
            if login{
                Utility.pushViewController(identifier: expenseListViewController, viewcontroller: self)
                DBManager.getInstance().featchDataFromTheTable()
            }
        }
        
        
    }
    
    
    func validateUI(flag: Bool){
        if flag{
            self.lblConfirmPasscode.isHidden = false
            self.txtConfirmPasscode.isHidden = false
            self.contentviewHeight.constant = 190.0
        }else{
            self.lblConfirmPasscode.isHidden = true
            self.txtConfirmPasscode.isHidden = true
            self.contentviewHeight.constant = 90.0
        }
    }
}

