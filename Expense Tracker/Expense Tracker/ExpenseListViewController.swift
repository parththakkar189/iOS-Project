//
//  ExpenseListViewController.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class ExpenseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ResultDelegate {
        

    @IBOutlet weak var tblExpenseList: UITableView!
    @IBOutlet weak var btnViewSats: UIButton!
    @IBOutlet weak var btnAddExpense: UIButton!
    
    var arrExpenseList = [Expense]()
    
    override func viewWillAppear(_ animated: Bool) {
        DBManager.getInstance().featchAllDataFromExpense()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DBManager.getInstance().resultDelegate = self
        self.tblExpenseList.reloadData()
        self.tblExpenseList.estimatedRowHeight = 70.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddExpesneClicked(sender: UIButton){
        
        Utility.pushViewController(identifier: addExpenseViewController, viewcontroller: self)
    }

    @IBAction func btnViewStatsClicked(sender: UIButton){
        Utility.pushViewController(identifier: graphViewController, viewcontroller: self)
        
    }
    
    //Result Delegate
    func resultWasGenerated(result: FMResultSet) {
        appdelegate.arrExpenseList = [Expense]()
        while result.next() {
            let expense = Expense(title: result.string(forColumn: "title")!, amount: result.double(forColumn: "amount"), note: result.string(forColumn: "note")!, date: result.string(forColumn: "date")!,catagory: result.string(forColumn: "catagory")!)
            appdelegate.arrExpenseList.append(expense)
        }
        appdelegate.arrExpenseList.reverse()
        self.tblExpenseList.reloadData()
    }
}


extension ExpenseListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appdelegate.arrExpenseList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: expenseDetailCell) as! ExpenseDetailCell
        cell.contentView.setBorder(color: themeColor)
        cell.updateViews(title: appdelegate.arrExpenseList[indexPath.row].title, catagory: "\(catagory)\(appdelegate.arrExpenseList[indexPath.row].catagory!.dropLast()),\n\(note)  \(appdelegate.arrExpenseList[indexPath.row].note!),\n\(date)\(appdelegate.arrExpenseList[indexPath.row].date!)", amount: "$\(appdelegate.arrExpenseList[indexPath.row].amount!)")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

