//
//  Constants.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import Foundation
import UIKit


//APPLICATION CONSTANTS
let themeColor = UIColor(displayP3Red: 15.0/255.0, green: 58.0/255.0, blue: 68.0/255.0, alpha: 1.0)
let dateFormatToConvert = "MM-dd-yyyy"
let emailREGex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
let dataBaseName = "Expense.db"
let signUpViewController = "SignUpVC"
let expenseListViewController = "ExpenseListVC"
let catagoryListViewController = "CatagoryListViewController"
let addExpenseViewController = "AddExpenseViewController"
let graphViewController = "GraphViewController"
let ISFIRSTTIME = "ISFIRSTTIME"
let PASSCODE = "PASSCODE"
let mainStoryBoard = "Main"
let mainScreen = UIScreen.main.bounds

let PLEASEENTERYOUREXPENSESTOSEETHETREND = "Please enter your expense to see the trend."
let PASSCODEDEOSNOTMATCH = "Passcode and Confirm passcode does not match"
let PASSCODELENGTH = "Passcode must be in 4 digits."
let LOGINERROR = "Please enter correct passcode."
let PLEASEENTERVALIDTITLE = "Please enter valid title."
let PLEASEENTERVALIDAMOUNT = "Please enter valid amount."
let PLEASEENTERVALIDDATE = "Please enter valid date."
let PLEASEENTERVALIDCATAGORY = "Please enter valid catagory."
let EXPENSEADDEDSUCCESSFULLY = "Expense added successfully."
let alertTitleAddExpense = "AddExpense"
let alertTitleRegister = "Register"
let alertActionTitle = "Ok"
let alertTitleLogin = "Login"
let expenseDetailCell = "ExpenseDetailCell"
let catagoryListTableViewCell = "CatagoryListTableViewCell"

let appdelegate = UIApplication.shared.delegate as! AppDelegate
let userDefaults = UserDefaults.standard


let expenseTable = "ExpenseRecord"
let catagoryTable = "Catagories"
let createExpenseTable = "CREATE TABLE IF NOT EXISTS \(expenseTable) (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, date TEXT, catagory TEXT, amount REAL) "
let createCatagoriesTable = "CREATE TABLE IF NOT EXISTS Catagories(id INTEGER PRIMARY KEY AUTOINCREMENT, catagoryname TEXT)"

//EXPENSE
let expensetitle = "Title: "
let note = "Note: "
let catagory = "Catagory: "
let date = "Date: "


//Graph
let DailyExpense = "Average Daily Expense"
let WeeklyExpense = "Average Weekly Expense"
let MonthlyExpense = "Average Monthly Expense"
let ExpenseTracker = "ExpeneTracker"
let ET = "ET"
let DailyAverageExpenseis = "Daily average expesne is $"
let WeeklyAverageExpenseis = "Weekly average expesne is $"
let MonthlyAverageExpenseis = "Monthly average expesne is $"
