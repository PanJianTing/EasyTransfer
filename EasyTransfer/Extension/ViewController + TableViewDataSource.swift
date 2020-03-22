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
        if(isTransferMode){
            return canTransferAccountModels.count;
        }
        return accountViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as UITableViewCell;
        
        let cell:UITableViewCell? = UITableViewCell(style: .subtitle, reuseIdentifier: "AccountCell");
        var accountViewModel:AccountViewModel?;
        if (isTransferMode){
            accountViewModel = canTransferAccountModels[indexPath.row]
        }else{
            accountViewModel = accountViewModels![indexPath.row];
        }
        cell?.textLabel?.text = accountViewModel?.showName;
        cell?.detailTextLabel?.text = accountViewModel?.showAccountStr
        
        return cell!
    }

}
