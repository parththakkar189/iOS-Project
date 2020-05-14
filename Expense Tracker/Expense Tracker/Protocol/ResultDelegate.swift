//
//  Result.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import Foundation

protocol ResultDelegate {
    func resultWasGenerated(result: FMResultSet)
}
