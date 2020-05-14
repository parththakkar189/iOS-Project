//
//  CatagoryListTableViewCell.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class CatagoryListTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelectCatagory: UIButton!
    @IBOutlet weak var lblCatagoryName: UILabel!
    
    var catagoryListVC = UIViewController()
    
    func updateViews(catagoryname: Catagories, viewController: UIViewController){
        self.lblCatagoryName.text = catagoryname.catagoryname
        self.btnSelectCatagory.setBorder(withColor: themeColor)
        if(catagoryname.selected == true){
            self.btnSelectCatagory.backgroundColor = themeColor
        }
        else{
            self.btnSelectCatagory.backgroundColor = UIColor.white
        }
        
        self.catagoryListVC = viewController
    }

    @IBAction func btnCatagoryChecked(sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: (catagoryListVC as! CatagoryListViewController).tblCatagoryList)
        let indexPath = (catagoryListVC as! CatagoryListViewController).tblCatagoryList.indexPathForRow(at: point)
        if sender.backgroundColor == UIColor.white{
            sender.backgroundColor = themeColor
            appdelegate.arrCatagories[indexPath!.row].selected = true
        }else{
            sender.backgroundColor = UIColor.white
            appdelegate.arrCatagories[indexPath!.row].selected = false
            
        }
    }
}
