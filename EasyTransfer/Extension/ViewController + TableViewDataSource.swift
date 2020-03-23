//
//  ViewController + TableViewDataSource.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell? = UITableViewCell(style: .subtitle, reuseIdentifier: "AccountCell");
        var accountViewModel:AccountViewModel?;
        accountViewModel = accountViewModels![indexPath.row];
        cell?.textLabel?.text = accountViewModel?.showName;
        cell?.detailTextLabel?.text = accountViewModel?.showAccountStr
        
        return cell!
    }

}
