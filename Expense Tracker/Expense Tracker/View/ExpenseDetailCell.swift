//
//  ExpenseDetailCell.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class ExpenseDetailCell: UITableViewCell {

    @IBOutlet weak var lblExpenseTitle: UILabel!
    @IBOutlet weak var lblExpenseCatagory: UILabel!
    @IBOutlet weak var lblExpenseAmount: UILabel!
    
    func updateViews(title: String, catagory: String, amount: String){
        self.lblExpenseTitle.text = expensetitle + title
        self.lblExpenseAmount.text = amount
        self.lblExpenseCatagory.text = catagory
    }
}

extension UIView{
    func setBorder(color: UIColor){
        layer.borderWidth = 1.5
        layer.borderColor = color.cgColor
    }
}
