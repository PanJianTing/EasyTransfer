//
//  ViewController + TableViewDelegate.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if(!self.isTransferMode){
            let nextViewController = AccountDetailViewController();
            let accountViewModel = accountViewModels![indexPath.row];
            nextViewController.accountViewModel = accountViewModel;
            nextViewController.canTransferAccountModels = self.handleCanTransferAccounts(removeAccount:accountViewModel)
            
            self.navigationController?.pushViewController(nextViewController, animated: true);
        }else{
            let nextViewController = TransferResultViewController();
            self.transferViewModel?.toAccount = accountViewModels![indexPath.row];
            nextViewController.transferViewModel = self.transferViewModel
            self.navigationController?.pushViewController(nextViewController, animated: true);
        }
        
    }

}
