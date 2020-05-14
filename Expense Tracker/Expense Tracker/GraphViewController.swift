//
//  GraphViewController.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-13.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var lblDailyAvgExpense: UILabel!
    @IBOutlet weak var lblWeeklyAvgExpense: UILabel!
    @IBOutlet weak var lblMonthlyAvgExpense: UILabel!
    @IBOutlet weak var lblTotalExpense: UILabel!
    
    var arrDates = [Date]()
    var maximumDate: Date!
    var minimumDate: Date!
    var totalExpense: Double = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isDataToShow(){
            setUpData()
            addGraphView(dimensions: 380.0)
        }
        else{
            Utility.AlertMessage(title: ExpenseTracker, message: PLEASEENTERYOUREXPENSESTOSEETHETREND, alertActionTitile: alertActionTitle, viewController: self)
        }
        
    }
    
    
    @IBAction func btnDoneClicked(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func isDataToShow() -> Bool{
        if appdelegate.arrExpenseList.count > 0{
            return true
        }
        return false
    }
    
    func setUpData() {
        setUpGraphData(arr: appdelegate.arrExpenseList)
        if arrDates.count > 1{
            arrDates.sort(by: { $0.compare($1) == .orderedAscending })
            let dateInstance = arrDates.map({$0})
            let _ = dateInstance.reduce(into: dateInstance[0], { (x, y) in
                if x.compare(y) == .orderedAscending{
                    minimumDate = x
                    maximumDate = y
                }
                else if x.compare(y) == .orderedSame{
                    minimumDate = x
                    maximumDate = y
                }
            })
        }else{
            minimumDate = Utility.dateFromString(dateStr: Utility.stringFromDate(date: Calendar.current.date(byAdding: .day, value: -1, to: Date(), wrappingComponents: false)!))
            maximumDate = arrDates[0]
        }
        
    }
    
    func setUpGraphData(arr: [Expense]){
        for var expense in arr{
            expense.actualdate = Utility.dateFromString(dateStr: expense.date)
            arrDates.append(expense.actualdate)
        }
        arrDates.reverse()

    }
    
    func MakeGraph() -> (Double, Double, Double) {
        self.totalExpense = Double()
        let _ =  appdelegate.arrExpenseList.reduce(into: appdelegate.arrExpenseList[0].amount, { (amountX, amountY) in
            self.totalExpense += amountY.amount
        })
        self.lblTotalExpense.text! += "Total\n"+"\(self.totalExpense)"
        var dailyAvgExpense = Double()
        var weeklyAvgExpense = Double()
        var monthlyAvgExpense = Double()
        if Double(Utility.getDistinctDays(minimumdate: self.minimumDate, maximumDate: self.maximumDate)) >= 30{
            dailyAvgExpense = self.totalExpense / Double(Utility.getDistinctDays(minimumdate: self.minimumDate, maximumDate: self.maximumDate))
            self.lblDailyAvgExpense.text = String(format: "\(DailyAverageExpenseis) %.2f", dailyAvgExpense)
            weeklyAvgExpense = self.totalExpense / Double(Utility.getDistinctMonth(minimumdate: self.minimumDate, maximumDate: self.maximumDate) * 4)
            self.lblWeeklyAvgExpense.text = String(format: "\(WeeklyAverageExpenseis) %.2f", weeklyAvgExpense)
            monthlyAvgExpense = self.totalExpense / Double(Utility.getDistinctMonth(minimumdate: self.minimumDate, maximumDate: self.maximumDate))
            self.lblMonthlyAvgExpense.text = String(format: "\(MonthlyAverageExpenseis) %.2f", monthlyAvgExpense)
        }
        else{
            
            if Double(Utility.getDistinctDays(minimumdate: self.minimumDate, maximumDate: self.maximumDate)) == 0{
                dailyAvgExpense = self.totalExpense / 1
            }
            else{
                dailyAvgExpense = self.totalExpense / Double(Utility.getDistinctDays(minimumdate: self.minimumDate, maximumDate: self.maximumDate))
            }

            self.lblDailyAvgExpense.text = String(format: "\(DailyAverageExpenseis) %.2f", dailyAvgExpense)
            weeklyAvgExpense = self.totalExpense / 4
            self.lblWeeklyAvgExpense.text = String(format: "\(WeeklyAverageExpenseis) %.2f", weeklyAvgExpense)
            monthlyAvgExpense = self.totalExpense / 30
            self.lblMonthlyAvgExpense.text = String(format: "\(MonthlyAverageExpenseis) %.2f", monthlyAvgExpense)
        }
        
        let ratio = getRatio(daily: dailyAvgExpense, weekly: weeklyAvgExpense, monthly: monthlyAvgExpense, totalExpense: self.totalExpense)
        return(ratio.0,ratio.1,ratio.2)
    }
    
    func getRatio(daily: Double, weekly: Double, monthly: Double, totalExpense: Double) -> (Double, Double, Double){
        let dailyRatio = (daily * 100)/totalExpense
        let weeklyRatio = (weekly * 100)/totalExpense
        let monthlyRatio = (monthly * 100)/totalExpense
        return(dailyRatio, weeklyRatio, monthlyRatio)
    }
    
    
    func addGraphView(dimensions: CGFloat) {
        let screenWidth = mainScreen.width
        let screenHeight = mainScreen.height

       let avgExpense = MakeGraph()
        
        let firstItem: RKPieChartItem = RKPieChartItem(ratio: uint(avgExpense.0), color: .purple, title: DailyExpense)
        let secondItem: RKPieChartItem = RKPieChartItem(ratio: uint(avgExpense.1), color: .gray, title: WeeklyExpense)
        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: uint(avgExpense.2), color: .yellow, title: MonthlyExpense)
        let chartView = RKPieChartView(items: [firstItem, secondItem, thirdItem], centerTitle: ET)
        chartView.circleColor = .darkGray
        chartView.arcWidth = 80
        chartView.isIntensityActivated = false
        chartView.style = .butt
        chartView.isTitleViewHidden = false
        chartView.isAnimationActivated = true
        chartView.frame = CGRect(x: (screenWidth - dimensions)/2, y: (screenHeight - dimensions)/2, width: dimensions, height: dimensions)
        self.view.addSubview(chartView)

    }
}
