//
//  CatagoryListViewController.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

class CatagoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tblCatagoryList: UITableView!
    var catagorySelectDelegate: CatagorySelectDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblCatagoryList.reloadData()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnDoneClicked(sender: UIButton){
        self.catagorySelectDelegate?.catagoryWasSelected(sender: appdelegate.arrCatagories)
        self.navigationController?.popViewController(animated: true)
    }

    
    
}

extension CatagoryListViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appdelegate.arrCatagories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: catagoryListTableViewCell) as! CatagoryListTableViewCell
        let catagoryMain = appdelegate.arrCatagories[indexPath.row] as Catagories
        cell.updateViews(catagoryname: catagoryMain, viewController: self)
         return cell
    }
}

extension UIButton{
    
    func setBorder(withColor: UIColor){
        self.layer.borderWidth = 2.0
        self.layer.borderColor = withColor.cgColor
    }
}
