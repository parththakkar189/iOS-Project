//
//  Expense.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import Foundation

struct Expense {
    var title: String!
    var amount: Double!
    var note: String?
    var date: String!
    var catagory: String!
    var actualdate: Date = Date()
}
