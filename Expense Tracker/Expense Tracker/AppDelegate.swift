//
//  AppDelegate.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-11.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate, ResultDelegate {
    

    
    var isFirstTime: Bool = true
    var passcode: String = String()
    var arrCatagories = [Catagories]()
    var arrSelectedCatagories: [Catagories] = [Catagories]()
    var arrExpenseList = [Expense]()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Utility.makeDataBase(fileName: dataBaseName)
        userDefaults.register(defaults: [ISFIRSTTIME : isFirstTime, PASSCODE: passcode])
        DBManager.getInstance().resultDelegate = appdelegate
        return true
    }

    func resultWasGenerated(result: FMResultSet) {
        self.arrCatagories = [Catagories]()
        while result.next() {
            let catagory = Catagories(id: Int(result.int(forColumn: "id")), catagoryname: result.string(forColumn: "catagoryname")!)
            appdelegate.arrCatagories.append(catagory)
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

