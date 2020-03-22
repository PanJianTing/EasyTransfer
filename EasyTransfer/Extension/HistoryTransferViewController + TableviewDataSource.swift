//
//  HistoryTransferViewController + TableviewDataSource.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

extension HistoryTransferViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return self.transferViewModels?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as UITableViewCell;
            
//            let cell:UITableViewCell? = UITableViewCell(style: .subtitle, reuseIdentifier: "HistoryCell");

            cell.textLabel?.text = transferViewModels?[indexPath.row].showTransferDetail();
            
            return cell
        }

}
